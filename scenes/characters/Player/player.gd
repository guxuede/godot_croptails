extends CharacterBody2D
class_name Player
@onready var hit_compoment: HitCompoment = $HitCompoment
var current_tool: InventoryItem

@onready var characters_stats: CharactersStats = $CharactersStats


var player_direction: Vector2

func _ready() -> void:
	ToolManager.tool_selected.connect(on_tool_selected)
	#watering_damge_stat = Stat.new_stat(1)

func on_tool_selected(tool: InventoryItem) -> void:
	current_tool = tool
	hit_compoment.current_tool = tool


func _physics_process(delta: float) -> void:
	hit_compoment.hit_damage = characters_stats.stats_map["wateting_damage"].value
