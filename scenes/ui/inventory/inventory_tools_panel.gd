extends PanelContainer

@onready var ctrl_inventory_grid: CtrlInventoryGrid = $MarginContainer/CtrlInventoryGrid
@onready var inventory: Inventory = $Inventory

func _ready() -> void:
	ctrl_inventory_grid.item_mouse_entered.connect(UiManager.notify_inventory_item_mouse_entered)
	ctrl_inventory_grid.item_mouse_exited.connect(UiManager.notify_inventory_item_mouse_exited)

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	inventory.inventory.remove_item(data)
	# Add custom logic for handling the item drop here


func _on_ctrl_inventory_grid_inventory_item_selected(item: InventoryItem) -> void:
	var itemId:String = item.get_prototype().get_id()
	print("item_selected", itemId)
	ToolManager.selecte_tool(item)
