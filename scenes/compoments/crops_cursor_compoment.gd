class_name CropsCursorCompoment
extends Node2D


@export var tilled_soil_tilemap_layer: TileMapLayer
@export var cropFields: Node2D
@onready var player: Player = get_tree().get_first_node_in_group("player")

var mouse_position:Vector2
var cell_position:Vector2i
var cell_source_id: int
var local_cell_position:Vector2
var distance: float

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("remove_dirt"):
		if ToolManager.get_selecte_tool_id() == "tool_tilling":
			get_cell_under_mouse()
			remove_crops()
	elif event.is_action_pressed("hit"):
		if ToolManager.get_selecte_tool_category() == "Seed":
			get_cell_under_mouse()
			add_crops()

	

func get_cell_under_mouse() -> void:
	mouse_position = tilled_soil_tilemap_layer.get_local_mouse_position()
	cell_position = tilled_soil_tilemap_layer.local_to_map(mouse_position)
	cell_source_id = tilled_soil_tilemap_layer.get_cell_source_id(cell_position)
	local_cell_position = tilled_soil_tilemap_layer.map_to_local(cell_position)
	distance = player.global_position.distance_to(local_cell_position)
	print("CropsCursorCompoment mouse_position: ", mouse_position, "cell_position: ", cell_position, "cell_source_id: ", cell_source_id, "local_cell_position:", local_cell_position, "distance:", distance)

func add_crops() -> void:
	if distance < 60.0 :
		if cell_source_id != -1:
			if ToolManager.get_selecte_tool_category() == "Seed":
				var plant_scece = load(ToolManager.selected_tool.get_property("plant_scene")) 
				var corn_obj = plant_scece.instantiate() as Node2D
				corn_obj.global_position = local_cell_position
				cropFields.add_child(corn_obj)
		else:
			print("Please plant in tilled dirt")
	else:
		print("too far")

	

func remove_crops() -> void:
	if distance < 60.0:
		var crop_nodes = cropFields.get_children()
		for node:Node2D in crop_nodes:
			if node.global_position == local_cell_position:
				node.queue_free()
	else:
		print("too far")
