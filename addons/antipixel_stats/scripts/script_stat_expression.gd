@tool
class_name StatExpression extends Resource

enum Operation {
	ADD,
	SUBTRACT,
	MULTIPLY,
	DIVIDE
}

@export var id: String:
	set(value): id = value; resource_name = value
@export var stat: Stat
@export var operation: Operation
@export var value: float
@export var priority: int

var formula: Callable:
	get:
		match operation:
			Operation.ADD: return func(v: float) -> float: return v + value
			Operation.SUBTRACT: return func(v: float) -> float: return v - value
			Operation.MULTIPLY: return func(v: float) -> float: return v * value
			Operation.DIVIDE: return func(v: float) -> float: return v / value
			_: return func(v: float) -> float: return v

func apply() -> void:
	match operation:
		Operation.ADD: stat.base_value += value
		Operation.SUBTRACT: stat.base_value -= value
		Operation.MULTIPLY: stat.base_value *= value
		Operation.DIVIDE: stat.base_value /= value

func inverse() -> void:
	match operation:
		Operation.ADD: stat.base_value -= value
		Operation.SUBTRACT: stat.base_value += value
		Operation.MULTIPLY: stat.base_value /= value
		Operation.DIVIDE: stat.base_value *= value

func get_mod(source: Object = null) -> StatModifier:
	return StatModifier.new_mod(formula, priority, source if source else self)
