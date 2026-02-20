class_name FieldCursorCompoment
extends Node2D

@export var grass_tilemap_layer: TileMapLayer
@export var tilled_soil_tilemap_layer: TileMapLayer
@export var terrain_set: int = 0
@export var terrain: int = 3
@onready var player: Player = get_tree().get_first_node_in_group("player")



var mouse_position:Vector2
var cell_position:Vector2i
var cell_source_id: int
var local_cell_position:Vector2
var distance: float

var last_mouse_position:Vector2

func _unhandled_input(event: InputEvent) -> void:
	var mouse_pos = get_global_mouse_position()
	if grass_tilemap_layer!=null and mouse_pos!= last_mouse_position:
		last_mouse_position = mouse_pos
		get_cell_under_mouse()

	if event.is_action_pressed("remove_dirt"):
		if ToolManager.selected_tool == DatTypes.Tools.TillGround:
			remove_tilled_soil_cell()
	elif event.is_action_pressed("hit"):
		if ToolManager.selected_tool == DatTypes.Tools.TillGround:
			add_tilled_soil_cell()


func get_cell_under_mouse() -> void:
	mouse_position = grass_tilemap_layer.get_local_mouse_position()
	cell_position = grass_tilemap_layer.local_to_map(mouse_position)
	cell_source_id = grass_tilemap_layer.get_cell_source_id(cell_position)
	local_cell_position = grass_tilemap_layer.map_to_local(cell_position)

	distance = player.global_position.distance_to(local_cell_position)
	
	global_position = local_cell_position
	
	#print("FieldCursorCompoment mouse_position: ", mouse_position, "cell_position: ", cell_position, "cell_source_id: ", cell_source_id, "local_cell_position:", local_cell_position, "distance:", distance)

func add_tilled_soil_cell() -> void:
	if distance < 60.0:
		if cell_source_id != -1:
			tilled_soil_tilemap_layer.set_cells_terrain_connect([cell_position],terrain_set, terrain, true)
		else:
			print("only glass terrain can be tilled")
	else:
		print("too far")
	

func remove_tilled_soil_cell() -> void:
	if distance < 60.0:
			tilled_soil_tilemap_layer.set_cells_terrain_connect([cell_position],0, -1, true)
	else:
		print("too far")
