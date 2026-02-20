extends NodeState

@export var character: NonPlayableCharacter
@export var animated_sprite_2d: AnimatedSprite2D
@export var navigation_agent_2d: NavigationAgent2D
@export var min_speed: float = 5
@export var max_speed: float = 10

var speed: float

func _ready() -> void:
	navigation_agent_2d.velocity_computed.connect(on_safe_velocity_computed)
	call_deferred("character_setup")
	
func character_setup() -> void:
	await get_tree().physics_frame
	set_movement_target()

func set_movement_target() -> void:
	var target_position:Vector2 = NavigationServer2D.map_get_random_point(navigation_agent_2d.get_navigation_map(),navigation_agent_2d.navigation_layers,false)
	navigation_agent_2d.target_position = target_position
	speed = randf_range(min_speed, max_speed)

func on_process(_delta : float):
	pass


func on_physics_process(_delta : float):
	if navigation_agent_2d.is_navigation_finished():
		character.currect_walk_cycle +=1
		set_movement_target()
		return
	var target_position:Vector2 = navigation_agent_2d.get_next_path_position()
	var target_direction:Vector2 = character.global_position.direction_to(target_position)
	
	var velocity:Vector2 = target_direction * speed
	
	if navigation_agent_2d.avoidance_enabled:
		animated_sprite_2d.flip_h = velocity.x < 0
		navigation_agent_2d.velocity = velocity
	else:
		character.velocity = velocity
		character.move_and_slide()

	
func on_safe_velocity_computed(safe_velocity : Vector2) -> void:
	animated_sprite_2d.flip_h = safe_velocity.x < 0
	character.velocity = safe_velocity
	character.move_and_slide()



func on_next_transitions(_delta : float):
	if character.currect_walk_cycle == character.walk_cycle:
		character.velocity = Vector2.ZERO
		transition.emit("Idle")

func on_enter():
	animated_sprite_2d.play("walk")
	character.currect_walk_cycle = 0


func on_exit():
	animated_sprite_2d.stop()
