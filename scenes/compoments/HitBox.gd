class_name HitBox extends HitCompoment

signal Damaged(damage: int,hitPostion:Vector2)

func takeDamage(damage: int,  hitPostion:Vector2) ->void:
	print("takeDamage:", damage)
	Damaged.emit(damage,hitPostion)
