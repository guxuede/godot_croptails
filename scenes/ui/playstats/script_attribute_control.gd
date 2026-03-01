@tool
extends StatControl

@export_group("Parameters")
@export var attribute_expression: StatExpression
@export var stat_expresions: Array[StatExpression]

@export_group("References")
@export var add_button: Button
@export var subtract_button: Button

var attribute: Stat:
	get: return attribute_expression.stat

func _ready() -> void:
	add_button.pressed.connect(_on_add_button_pressed)
	subtract_button.pressed.connect(_on_subtract_button_pressed)

func _on_add_button_pressed() -> void:
	if attribute.value < attribute.max_stat.value:
		do(func(e: StatExpression) -> void: e.apply())
	attribute_expression.apply()

func _on_subtract_button_pressed() -> void:
	if attribute.value > attribute.min_stat.value:
		do(func(e: StatExpression) -> void: e.inverse())
	attribute_expression.inverse()

func do(f: Callable) -> void:
	for expression: StatExpression in stat_expresions:
		f.call(expression)

func update() -> void:
	if name_label:
		name_label.text = name_text
	if stat_label:
		if stat: stat_label.stat = stat
		stat_label.prefix = prefix
		stat_label.suffix = suffix
		stat_label.is_percentage = is_percentage
