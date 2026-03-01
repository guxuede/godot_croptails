extends Node

signal inventory_changed
signal inventory_item_collected(collectable_name: String, stack_size: int)

var moneny: int = 0

func add_collectable(collectable_name: String, stack_size: int = 1) -> void:
	if collectable_name == "moneny":
		moneny += stack_size
	inventory_item_collected.emit(collectable_name, stack_size)
	inventory_changed.emit()
