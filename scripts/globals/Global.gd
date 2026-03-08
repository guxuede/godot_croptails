extends Node

const STATS:Dictionary = {
	"MaxHealth": &"MaxHealth",
	"Health": &"Health",
	"Strength": &"Strength",
	"WateringDamage": &"WateringDamage",
	"MaxWateringDamage": &"MaxWateringDamage",
}

func await_timer(_time:float) -> void:
	await get_tree().create_timer(_time).timeout




func get_selecte_tool_id(selected_tool:InventoryItem) -> String:
	if selected_tool!=null:
		var select_id = selected_tool.get_prototype().get_id();
		return select_id
	return "None"

func get_selecte_tool_category(selected_tool:InventoryItem) -> String:
	if selected_tool!=null:
		return selected_tool.get_prototype().get_property("category")
	
	return "None"


func get_item_id(selected_tool:InventoryItem) -> String:
	if selected_tool!=null:
		var select_id = selected_tool.get_prototype().get_id();
		return select_id
	return "None"

func get_item_category(selected_tool:InventoryItem) -> String:
	if selected_tool!=null:
		return selected_tool.get_prototype().get_property("category")
	
	return "None"
