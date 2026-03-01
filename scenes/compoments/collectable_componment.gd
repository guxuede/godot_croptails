class_name CollectableComponment
extends Area2D

@export var collectable_name: String
@export var stack_size: int = 1

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		InventoryManager.add_collectable(collectable_name,stack_size)
		print("Collected:", collectable_name)
		get_parent().queue_free()
