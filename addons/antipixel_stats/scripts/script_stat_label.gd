@tool
class_name StatLabel extends Label

@export var stat: Stat:
	set(value): stat = value; update()
@export var prefix: String:
	set(value): prefix = value; update()
@export var suffix: String:
	set(value): suffix = value; update()
@export var is_percentage: bool:
	set(value): is_percentage = value; update()

func _ready() -> void:
	if not stat: return
	stat.value_changed.connect(_on_value_changed)

func _on_value_changed() -> void:
	update()

func update() -> void:
	if not stat: return
	
	var float_value: float = stat.value
	var value: String = str(float_value)
	
	if is_percentage:
		value = str(roundi(float_value * 100))
	else:
		var int_value: int = int(float_value)
		if is_equal_approx(float_value, int_value):
			value = str(int_value)
	
	text = str(prefix, value, suffix)
