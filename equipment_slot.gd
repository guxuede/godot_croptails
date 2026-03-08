extends Control

@onready var player: Player = get_tree().get_first_node_in_group("player")

@onready var ctrl_item_slot: CtrlItemSlot = $CtrlItemSlot
@onready var item_slot: ItemSlot = $CtrlItemSlot/ItemSlot


var mod : StatModifier
var stat_id:String
func _ready() -> void:
	ctrl_item_slot.item_slot.item_equipped.connect(on_item_equipped)
	ctrl_item_slot.item_slot.cleared.connect(on_item_unequipped)
	
	ctrl_item_slot.item_mouse_entered.connect(UiManager.notify_inventory_item_mouse_entered)
	ctrl_item_slot.item_mouse_exited.connect(UiManager.notify_inventory_item_mouse_exited)

	pass

func on_item_equipped() -> void:
	print("on_item_equipped")
	var item = item_slot.get_item()
	var modifiers_path = item.get_property("modifiers")
	if modifiers_path != null:
		var statExpression = load(modifiers_path) as StatExpression
		stat_id = statExpression.stat.id
		mod = statExpression.get_mod() #genereate modifiers
		player.characters_stats.add_mod(stat_id, mod)



func on_item_unequipped(item: InventoryItem) -> void:
	print("on_item_unequipped", item)
	if mod != null:
		player.characters_stats.remove_mod(stat_id, mod)
		mod = null


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_inventory_panel"):
		if is_visible_in_tree():
			hide()
		else:
			show()
