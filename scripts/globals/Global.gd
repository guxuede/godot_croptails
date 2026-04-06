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
	
func get_item_hand_image(selected_tool:InventoryItem) -> Texture2D:
	if selected_tool!=null:
		var hand_image = selected_tool.get_prototype().get_property("hand_image")
		if hand_image != null:
			return load(hand_image)
		else:
			return load(selected_tool.get_prototype().get_property("image"))
	return null
	
func get_item_has_handle(selected_tool:InventoryItem) -> bool:
	if selected_tool!=null:
		var hand_image = selected_tool.get_prototype().get_property("has_handle")
		if hand_image != null:
			return true
		else:
			return false
	return false
