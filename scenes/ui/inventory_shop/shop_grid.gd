extends PanelContainer

@onready var player: Player = get_tree().get_first_node_in_group("player")


@onready var ctrl_inventory_grid: CtrlInventoryGrid = $HBoxContainer/VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/PanelContainer/CtrlInventoryGrid
@onready var btn_buy: Button = $HBoxContainer/VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/BtnBuy
@onready var inventory: Inventory = $Inventory


var item_template_scece = preload("res://scenes/objects/item_template.tscn")

func _ready() -> void:
	hide()
	ctrl_inventory_grid.item_mouse_entered.connect(UiManager.notify_shop_inventory_item_mouse_entered)
	ctrl_inventory_grid.item_mouse_exited.connect(UiManager.notify_shop_inventory_item_mouse_exited)
	btn_buy.pressed.connect(on_buy_button_prcessed)

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return false #data is InventoryItem

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	print("_drop_data", data)


func on_buy_button_prcessed() -> void:
	var selected_items: Array[InventoryItem] = ctrl_inventory_grid.get_selected_inventory_items()
	if selected_items.is_empty():
		return

	for selected_item in selected_items:
		var stack_size = selected_item.get_stack_size()
		InventoryManager.add_collectable(selected_item.get_prototype().get_id(),stack_size)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_shop_panel"):
		if is_visible_in_tree():
			hide()
		else:
			show()
