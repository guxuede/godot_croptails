class_name ActorPlayerAnimation
extends AnimationPlayer


@export var player: Player1

func playAnimation(name:String):
	var dir = convertDegreesToDirection(player.directionAngle)
	play(name + "_" + dir)
	pass
	
	

func convertDegreesToDirection(angle):
	var direction_id = int(round(angle / TAU * 4))
	var direction = "down";
	if direction_id == 1:
		direction = "down";
	elif direction_id == 2 or direction_id== -2:
		direction = "left"
	elif direction_id == -1:
		direction = "up"
	elif direction_id == 0:
		direction = "right"
	return direction;
