class_name DayNightCycleCompoment
extends CanvasModulate

@export var initial_day: int = 1:
		set(number):
			initial_day = number
			DayAndNightManager.initial_day = number
			DayAndNightManager.set_initial_time()

@export var initial_hour: int = 12:
		set(number):
			initial_hour = number
			DayAndNightManager.initial_hour = number
			DayAndNightManager.set_initial_time()
			
@export var initial_minute: int = 30:
		set(number):
			initial_minute = number
			DayAndNightManager.initial_minute = number
			DayAndNightManager.set_initial_time()

@export var day_night_gradient_texture:  GradientTexture1D

func _ready() -> void:
		DayAndNightManager.initial_day = initial_day
		DayAndNightManager.initial_hour = initial_hour
		DayAndNightManager.initial_minute = initial_minute
		DayAndNightManager.set_initial_time()
		
		DayAndNightManager.game_time.connect(on_game_time)


func on_game_time(time:float) -> void:
		var sample_value = 0.5 * (sin(time - PI* 0.5) + 1.0)
		color = day_night_gradient_texture.gradient.sample(sample_value)
	
