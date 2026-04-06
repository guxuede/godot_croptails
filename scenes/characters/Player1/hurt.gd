extends LimboState
## Idle state.

@export var player: Player1
@export var actorPlayerAnimation: ActorPlayerAnimation


func _enter() -> void:
	player.velocity = Vector2.ZERO
	actorPlayerAnimation.playAnimation("hurt")
	await actorPlayerAnimation.animation_finished
	get_root().dispatch(EVENT_FINISHED)


func _update(delta: float) -> void:
		player.moveBackAndFromLastHurtPosition(delta)
		
