@tool
class_name Stat extends Resource

signal base_value_changed
signal value_changed

@export var id: String:
	set(val): id = val; resource_name = val
@export var base_value: float:
	get: return base_value
	set(val):
		var temp: float = base_value
		base_value = val
		if min_stat and base_value < min_stat.value:
			base_value = min_stat.value
		elif max_stat and base_value > max_stat.value:
			base_value = max_stat.value
		if base_value != temp:
			prev_base_value = temp
			base_value_changed.emit()
			calculate()
@export var min_stat: Stat
@export var max_stat: Stat

var value: float
var prev_base_value: float = NAN
var prev_value: float = NAN
var modifiers: Array[StatModifier]

var progress: float:
	get: return (value - min_stat.value) / (max_stat.value - min_stat.value) \
	if min_stat and max_stat else 0

static func new_stat(base_value: float) -> Stat:
	var stat: Stat = Stat.new()
	stat.base_value = base_value
	return stat

func calculate() -> void:
	var temp: float = value
	value = base_value
	
	modifiers.sort_custom(sort_descending)
	for mod: StatModifier in modifiers:
		value = mod.formula.call(value)
	
	if value != temp:
		prev_value = temp
		value_changed.emit()

func add_mod(mod: StatModifier) -> void:
	modifiers.append(mod)
	calculate()

func add_mod_array(mods: Array[StatModifier]) -> void:
	for mod: StatModifier in mods:
		modifiers.append(mod)
	calculate()

func replace_mod(old: StatModifier, new: StatModifier) -> bool:
	var i: int = modifiers.find(old)
	if i != -1:
		modifiers[i] = new
		calculate()
		return true
	return false

func remove_mod(mod: StatModifier) -> bool:
	var i: int = modifiers.find(mod)
	if i != -1:
		modifiers.remove_at(i)
		calculate()
		return true
	return false

func remove_mod_array(mods: Array[StatModifier]) -> bool:
	var output: bool
	for mod: StatModifier in mods:
		if remove_mod(mod):
			output = true
	if output: calculate()
	return output

func remove_all_mods() -> bool:
	if modifiers.is_empty(): return false
	modifiers.clear()
	calculate()
	return true

func remove_source(source: Object) -> bool:
	var mods: Array[StatModifier] = modifiers.filter(filter_source.bind(source))
	if not mods.is_empty():
		for mod: StatModifier in mods:
			modifiers.erase(mod)
		calculate()
		return true
	return false

func remove_source_array(sources: Array[Object]) -> bool:
	var output: bool
	for source: Object in sources:
		if remove_source(source):
			output = true
	return output

func filter_source(mod: StatModifier, source: Object) -> bool:
	return mod.source == source

func sort_descending(a: StatModifier, b: StatModifier) -> bool:
	return a.priority > b.priority
