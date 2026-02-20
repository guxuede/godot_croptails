extends CharacterBody2D
class_name Player
@onready var hit_compoment: HitCompoment = $HitCompoment

@export var current_tool: DatTypes.Tools = DatTypes.Tools.None
var player_direction: Vector2

func _ready() -> void:
	ToolManager.tool_selected.connect(on_tool_selected)
	
func on_tool_selected(tool: DatTypes.Tools) -> void:
	current_tool = tool
	hit_compoment.current_tool = tool
