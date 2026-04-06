extends LimboState
## Idle state.

@export var animations: Array[StringName]
@export var player: Player1
@export var actorPlayerAnimation: ActorPlayerAnimation


func _enter() -> void:
	player.velocity = Vector2.ZERO
	actorPlayerAnimation.playAnimation(animations.pick_random())
	await actorPlayerAnimation.animation_finished
	if is_active():
		get_root().dispatch(EVENT_FINISHED)
