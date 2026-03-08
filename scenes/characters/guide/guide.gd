extends Node2D

var ballon_scene =preload("res://dialogue/game_dialogue_balloon.tscn")

@onready var interactable_componment: InteractableCompomment = $InteractableComponment
@onready var interactable_lable_componment: Control = $InteractableLableComponment

var in_range: bool

func _ready() -> void:
	interactable_componment.interactable_activated.connect(on_interactable_activated)
	interactable_componment.interactable_deactivated.connect(on_interactable_deactivated)
	interactable_lable_componment.hide()


func on_interactable_activated() -> void:
	interactable_lable_componment.show() #???
	in_range = true

func on_interactable_deactivated() -> void:
	interactable_lable_componment.hide()
	in_range = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("show_dialogue"):
		if in_range == true:
			var ballon:BaseDialogueManagerBalloon = ballon_scene.instantiate();
			get_tree().root.add_child(ballon)
			ballon.start(load("res://dialogue/conversations/guide.dialogue"),"start")
