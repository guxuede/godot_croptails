extends StaticBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var interactable_compomment: InteractableCompomment = $InteractableComponment
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	interactable_compomment.interactable_activated.connect(on_interactable_activated)
	interactable_compomment.interactable_deactivated.connect(on_interactable_deactivated)
	collision_layer = 1
	
	
	
func on_interactable_activated() -> void:
	animated_sprite_2d.play("open_door")
	collision_layer = 2
	pass
	
func on_interactable_deactivated() -> void:
	animated_sprite_2d.play("close_door")
	collision_layer = 1
	pass


func _on_interactable_compomment_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
