extends Control

@onready var player: Player = get_tree().get_first_node_in_group("player")

@onready var ctrl_inventory_grid: CtrlInventoryGrid = $VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/CtrlInventoryGrid
@onready var btn_sort: Button = $VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/BtnSort
@onready var btn_split: Button = $VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/BtnSplit
@onready var inventory: Inventory = $Inventory


var item_template_scece = preload("res://scenes/objects/item_template.tscn")

func _ready() -> void:
	hide()
	ctrl_inventory_grid.item_mouse_entered.connect(UiManager.notify_inventory_item_mouse_entered)
	ctrl_inventory_grid.item_mouse_exited.connect(UiManager.notify_inventory_item_mouse_exited)

	btn_sort.pressed.connect(_on_btn_sort.bind(ctrl_inventory_grid))
	btn_split.pressed.connect(_on_btn_split.bind(ctrl_inventory_grid))
	
	InventoryManager.inventory_item_collected.connect(on_inventory_item_collected)

func on_inventory_item_collected(collectable_name: String, stack_size: int)-> void:
	var item = inventory.create_item(collectable_name)
	item.set_stack_size(stack_size)
	inventory.add_item_autosplitmerge(item)

#
#func on_inventory_item_removed(collectable_name: String, stack_num: int)-> void:
	#print("_on_inventory_item_removed", collectable_name, stack_num)
	#var item: InventoryItem = inventory.get_item_with_prototype_id(collectable_name)
	#if item != null:
		#inventory.remove_item(item)


func _on_btn_sort(ctrl_inventory) -> void:
	if !ctrl_inventory.inventory.get_constraint(GridConstraint).sort():
		print("Warning: GridConstraint.sort() returned false!")


func _on_btn_split(ctrl_inventory) -> void:
	var selected_items: Array[InventoryItem] = ctrl_inventory.get_selected_inventory_items()
	if selected_items.is_empty():
		return

	for selected_item in selected_items:
		var stack_size = selected_item.get_stack_size()
		if stack_size < 2:
			return

		# All this floor/float jazz just to do integer division without warnings
		var new_stack_size: int = floor(float(stack_size) / 2)
		ctrl_inventory.inventory.split_stack(selected_item, new_stack_size)



func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is InventoryItem

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	print("_drop_data", data)
	var isRmoved = inventory.remove_item(data)
	if isRmoved:
		# Add custom logic for handling the item drop here
		var itemTemplate = item_template_scece.instantiate() as ItemTemplate
		itemTemplate.drop_from_inventory(data)
		itemTemplate.global_position = player.global_position + Vector2(20,20)
		get_tree().root.add_child(itemTemplate)


func _on_inventory_item_removed(item: InventoryItem) -> void:
	print("_on_inventory_item_removed", item)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_inventory_panel"):
		if is_visible_in_tree():
			hide()
		else:
			show()
