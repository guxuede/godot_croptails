extends LimboState
## Idle state.

@export var player: Player1
@export var actorPlayerAnimation: ActorPlayerAnimation


func _enter() -> void:
	player.velocity = Vector2.ZERO
	actorPlayerAnimation.playAnimation("idle")

func _update(delta: float) -> void:
	if !player.eventHandleEnable:
		return

	if Input.is_action_just_pressed("ui_use_skill"):
		get_root().dispatch(EVENT_FINISHED)
	elif Input.get_vector("move_left", "move_right", "move_up", "move_down").length() > 0:
		get_root().dispatch(EVENT_FINISHED)
	elif Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_LEFT):
		player.faceToMouse()
		if Global.get_selecte_tool_id(player.current_tool) == "tool_axe":
			get_root().dispatch("chopping")
		if Global.get_selecte_tool_id(player.current_tool) == "tool_tilling":
			get_root().dispatch("tilling")
		if Global.get_selecte_tool_id(player.current_tool) == "tool_watering":
			get_root().dispatch("watering")
		if Global.get_item_category(player.current_tool) == "Weapon":
			get_root().dispatch("slash")
	if Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_RIGHT):
		$"../../NavigationAgent2D".target_position = player.get_global_mouse_position()
		get_root().dispatch(EVENT_FINISHED)
	else :
		pass
		

func _exit() -> void:
	player.velocity = Vector2.ZERO
