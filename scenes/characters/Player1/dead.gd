extends LimboState


@export var player: Player1
@export var actorPlayerAnimation: ActorPlayerAnimation

func _enter() -> void:
	player.velocity = Vector2.ZERO
	actorPlayerAnimation.playAnimation("dead")
	call_deferred("_disable_collision")


func _disable_collision():
	%HurtBox.monitoring = false
	%HitBox.monitorable = false
	%CollisionShape2D.set_disabled(true)
