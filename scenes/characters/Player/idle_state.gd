extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D


func on_process(_delta : float):
	pass


func on_physics_process(_delta : float):
	var direction = player.player_direction
	
	if direction == Vector2.UP:
		animated_sprite_2d.play("idle_back")
	elif direction == Vector2.DOWN:
		animated_sprite_2d.play("idle_front")
	elif direction == Vector2.LEFT:
		animated_sprite_2d.play("idle_left")
	elif direction == Vector2.RIGHT:
		animated_sprite_2d.play("idle_right")
	else:
		animated_sprite_2d.play("idle_front")

func _unhandled_input(event: InputEvent) -> void:
	GameInputEvents.movement_input()
	if GameInputEvents.is_movement_input():
		transition.emit("Walk")
	
	if GameInputEvents.use_tool():
		if player.current_tool == DatTypes.Tools.AxeWood:
			transition.emit("Chopping")
		if player.current_tool == DatTypes.Tools.TillGround:
			transition.emit("Tilling")
		if player.current_tool == DatTypes.Tools.WalterCrops:
			transition.emit("Watering")
	
func on_enter():
	pass


func on_exit():
	animated_sprite_2d.stop
	pass
