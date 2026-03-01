@tool
class_name StatControl extends Node

@export_group("Parameters")
@export var name_text: String:
	set(value): name_text = value; update()
@export var stat: Stat:
	set(value): stat = value; update()
@export var prefix: String:
	set(value): prefix = value; update()
@export var suffix: String:
	set(value): suffix = value; update()
@export var is_percentage: bool:
	set(value): is_percentage = value; update()

@export_group("References")
@export var name_label: Label:
	set(value): name_label = value; update()
@export var stat_label: StatLabel:
	set(value): stat_label = value; update()

func update() -> void:
	if name_label:
		name_label.text = name_text
	if stat_label:
		if stat: stat_label.stat = stat
		stat_label.prefix = prefix
		stat_label.suffix = suffix
		stat_label.is_percentage = is_percentage
