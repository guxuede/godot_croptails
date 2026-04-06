extends LimboState
## Idle state.

@export var player: Player1
@export var actorPlayerAnimation: ActorPlayerAnimation

func _enter() -> void:
	player.velocity = Vector2.ZERO
	actorPlayerAnimation.playAnimation("walk")

func _update(delta: float) -> void:
	if Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_RIGHT):
		$"../../NavigationAgent2D".target_position = player.get_global_mouse_position()

	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	# Set velocity based on input and speed
	if input_direction.length() > 0:
		#clear player navigation
		if not $"../../NavigationAgent2D".is_navigation_finished():
			$"../../NavigationAgent2D".target_position = player.position
		player.moveAndFaceToDirrection(input_direction, delta)
		actorPlayerAnimation.playAnimation("walk")
		# Flip the sprite to face the correct direction (for side-scrollers)
	elif not $"../../NavigationAgent2D".is_navigation_finished():
		var navDir = player.to_local($"../../NavigationAgent2D".get_next_path_position()).normalized()
		print("move with Navigation", player.position, navDir)
		player.moveAndFaceToDirrection(navDir, delta)
		actorPlayerAnimation.playAnimation("walk")
	else:
		get_root().dispatch(EVENT_FINISHED)
