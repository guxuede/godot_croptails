class_name HurtCompoment extends Area2D

@export var tool: String

signal hurt
signal hurt_with_item(hit_damage: int, item:InventoryItem)


func _on_area_entered(area: Area2D) -> void:
	var hit_compoment = area as HitCompoment
	if tool == Global.get_selecte_tool_id(hit_compoment.current_tool):
		hurt.emit(hit_compoment.hit_damage)
		hurt_with_item.emit(hit_compoment.hit_damage, hit_compoment.current_tool)
