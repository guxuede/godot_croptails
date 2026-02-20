extends Node2D

var balloon_scene = preload("res://dialogue/game_dialogue_balloon.tscn")

var corn_harvest_scene = preload("res://scenes/objects/plants/corn_harvest.tscn")
var tomato_harvest_scene = preload("res://scenes/objects/plants/tomato_harvest.tscn")

@export var dislogue_start_command:String
@export var food_drop_hight:int = 60
@export var reward_out_put_radiues: int = 20
@export var output_reward_scenes: Array[PackedScene] = []

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var interactable_componment: InteractableCompomment = $InteractableComponment
@onready var interactable_lable_componment: Control = $InteractableLableComponment
@onready var reward_marker: Marker2D = $RewardMarker
@onready var feed_compoment: FeedCompoment = $FeedCompoment

var in_range: bool
var is_chest_open: bool

func _ready() -> void:
	interactable_lable_componment.hide()
	interactable_componment.interactable_activated.connect(on_interactable_activated)
	interactable_componment.interactable_deactivated.connect(on_interactable_deactivated)
	
	GameDialogueManager.feed_animals.connect(on_feed_animals)
	
	feed_compoment.food_recevied.connect(on_food_recevied)

	
func on_interactable_activated() -> void:
	interactable_lable_componment.show()
	in_range = true

func on_interactable_deactivated() -> void:
	if is_chest_open:
		animated_sprite_2d.play("closing")
	is_chest_open = false
	interactable_lable_componment.hide()
	in_range = false
	
	
func _unhandled_input(event: InputEvent) -> void:		
		if in_range == true:
				if event.is_action_pressed("show_dialogue"):
					interactable_lable_componment.hide()
					animated_sprite_2d.play("opening")
					is_chest_open = true
					
					var ballon:BaseDialogueManagerBalloon = balloon_scene.instantiate()
					get_tree().root.add_child(ballon)
					ballon.start(load("res://dialogue/conversations/chest.dialogue"),dislogue_start_command)

	
func on_feed_animals() -> void:
	if in_range:
		trigger_feed_harvest("corn", corn_harvest_scene)
		trigger_feed_harvest("tomato", tomato_harvest_scene)
		
func trigger_feed_harvest(inventory_item:String, scene:Resource) -> void:
	var inventory : Dictionary  = InventoryManager.inventory
	
	if !inventory.has(inventory_item):
		return
		
	var inventory_item_count = inventory[inventory_item]
	
	for index in inventory_item_count:
		var harvest_instance = scene.instantiate() as Node2D
		harvest_instance.global_position = Vector2(global_position.x, global_position.y - food_drop_hight)
		get_tree().root.add_child(harvest_instance)
		
		var target_position = global_position
		var time_delay = randf_range(0.5, 2.0)
		await get_tree().create_timer(time_delay).timeout
		
		var tween: Tween  = get_tree().create_tween()
		tween.tween_property(harvest_instance, "position", target_position, 1.0)
		tween.tween_property(harvest_instance, "scale", Vector2(0.5,0.5), 1.0)
		tween.tween_callback(harvest_instance.queue_free)
		
		InventoryManager.remve_collectable(inventory_item)



func on_food_recevied(area:Area2D) -> void:
	call_deferred("add_reward_scence")

func add_reward_scence()-> void:
	for scene in output_reward_scenes:
		var reward_scene:Node2D = scene.instantiate()
		reward_scene.global_position = get_reward_position_random(reward_marker.global_position, reward_out_put_radiues)
		get_tree().root.add_child(reward_scene)
		
func get_reward_position_random(center:Vector2, radius: int) -> Vector2:
	var angle = randf() * TAU
	var distance_from_center = sqrt(randf()) *  radius
	
	var x: int = center.x + distance_from_center + cos(angle)
	var y: int = center.y + distance_from_center + cos(angle)

	return Vector2i(x, y)
