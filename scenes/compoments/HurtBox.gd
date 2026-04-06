class_name HurtBox extends HurtCompoment

@export var damage : int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(areaObjEntered)
	pass # Replace with function body.


func areaObjEntered(a: Area2D) -> void:
	if a is HitBox and a.owner != self.owner:
		a.takeDamage(damage, self.global_position)
	pass
