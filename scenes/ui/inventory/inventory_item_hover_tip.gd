extends Control
@onready var rich_text_label: RichTextLabel = $MarginContainer/VBoxContainer/RichTextLabel
@onready var label: Label = $MarginContainer/VBoxContainer/Label

@export var info_offset: Vector2 = Vector2(20, 0)

var isShowing: bool = false

func _ready() -> void:
	hide()
	UiManager.inventory_item_mouse_entered.connect(_on_item_mouse_entered)
	UiManager.inventory_item_mouse_exited.connect(_on_item_mouse_exited)

func _on_item_mouse_entered(item: InventoryItem) -> void:
	if item == null:
		return

	label.text = item.get_title()
	rich_text_label.text = item.get_property("description")
	show()
	isShowing = true

func _on_item_mouse_exited(_item: InventoryItem) -> void:
	hide()
	isShowing = false


func _input(event: InputEvent) -> void:
	if isShowing && !(event is InputEventMouseMotion):
		return
	set_global_position(get_global_mouse_position() + info_offset)
