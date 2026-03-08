extends Node
var selected_tool : InventoryItem

signal tool_selected(tool:InventoryItem)
signal enable_tool(tool:InventoryItem)

func selecte_tool(tool: InventoryItem) -> void:
	tool_selected.emit(tool)
	selected_tool = tool

func get_selecte_tool_id() -> String:
	return Global.get_selecte_tool_id(selected_tool)
	
func get_selecte_tool_category() -> String:
	return Global.get_selecte_tool_category(selected_tool)

func enable_tool_button(tool: InventoryItem) -> void:
	enable_tool.emit(tool)
