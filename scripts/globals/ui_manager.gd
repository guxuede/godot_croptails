extends Node

signal inventory_item_mouse_entered(item: InventoryItem)
signal inventory_item_mouse_exited(item: InventoryItem)

signal shop_inventory_item_mouse_entered(item: InventoryItem)
signal shop_inventory_item_mouse_exited(item: InventoryItem)

func notify_inventory_item_mouse_entered(item: InventoryItem) -> void:
	inventory_item_mouse_entered.emit(item)

func notify_inventory_item_mouse_exited(item: InventoryItem) -> void:
	inventory_item_mouse_exited.emit(item)



func notify_shop_inventory_item_mouse_entered(item: InventoryItem) -> void:
	shop_inventory_item_mouse_entered.emit(item)

func notify_shop_inventory_item_mouse_exited(item: InventoryItem) -> void:
	shop_inventory_item_mouse_exited.emit(item)
