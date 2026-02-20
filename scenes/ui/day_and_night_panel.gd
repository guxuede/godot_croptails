extends Control
@onready var day_label: Label = $DayPanel/MarginContainer/DayLabel
@onready var time_label: Label = $TimePanel/MarginContainer/TimeLabel

@export var normal_speed: int = 5
@export var fast_speed: int = 100
@export var cheat_speed: int = 300


func _ready() -> void:
	DayAndNightManager.time_tick.connect(on_time_tick)

	
func on_time_tick(day: int, hour: int, minutes: int) -> void:
	day_label.text = "Day " + str(day)
	time_label.text = "%02d:%02d" % [hour, minutes]
	
	


func _on_normal_speed_button_pressed() -> void:
	DayAndNightManager.game_speed = normal_speed
	

func _on_fast_speed_button_pressed() -> void:
	DayAndNightManager.game_speed = fast_speed


func _on_cheat_speed_button_pressed() -> void:
	DayAndNightManager.game_speed = cheat_speed
