extends PanelContainer

func _ready() -> void:
	hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_inventory_panel"):
		if is_visible_in_tree():
			hide()
		else:
			show()
