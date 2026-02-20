extends Node

@export var cursor_compoment_texture: Texture2D

func _ready() -> void:
	Input.set_custom_mouse_cursor(cursor_compoment_texture, Input.CURSOR_ARROW)
