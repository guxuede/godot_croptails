class_name HurtCompoment
extends Area2D

@export var tool: DatTypes.Tools = DatTypes.Tools.None

signal hurt



func _on_area_entered(area: Area2D) -> void:
	var hit_compoment = area as HitCompoment
	if tool == hit_compoment.current_tool:
		hurt.emit(hit_compoment.hit_damage)
