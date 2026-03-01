@tool
extends Button

@export_group("Parameters")
@export var name_text: String:
	set(value): name_text = value; update()
@export var mod_text: String:
	set(value): mod_text = value; update()
@export var expressions: Array[StatExpression]

@export_group("References")
@export var name_label: Label:
	set(value): name_label = value; update()
@export var mod_label: Label:
	set(value): mod_label = value; update()

var mods: Array[StatModifier]

func _ready() -> void:
	for expression: StatExpression in expressions:
		mods.append(expression.get_mod(self))

func _toggled(toggled_on: bool) -> void:
	match toggled_on:
		true:
			for i: int in expressions.size():
				expressions[i].stat.add_mod(mods[i])
		false:
			for i: int in expressions.size():
				expressions[i].stat.remove_mod(mods[i])

func update() -> void:
	if name_label: name_label.text = name_text
	if mod_label: mod_label.text = mod_text
