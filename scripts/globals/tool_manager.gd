extends Node
var selected_tool : DatTypes.Tools = DatTypes.Tools.None

signal tool_selected(tool:DatTypes.Tools)
signal enable_tool(tool:DatTypes.Tools)

func selecte_tool(tool: DatTypes.Tools) -> void:
	tool_selected.emit(tool)
	selected_tool = tool


func enable_tool_button(tool: DatTypes.Tools) -> void:
	enable_tool.emit(tool)
