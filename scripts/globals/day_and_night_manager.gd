extends Node

const HOURS_PER_DAY : int = 24
const MINUTES_PER_DAY : int = HOURS_PER_DAY * 60
const MINUTES_PER_HOUR : int = 60
const GMAE_MINUTES_DURATION : float = TAU/MINUTES_PER_DAY


var game_speed: float = 5.0

var initial_day: int = 1
var initial_hour: int = 12
var initial_minute: int = 30

var time: float = 0.0
var current_minutes: int = -1
var current_hour: int = 0
var current_day: int = 0

signal game_time(time: float)
signal time_tick(day: int, hour: int, minutes: int)
signal time_tick_day(day: int)
signal game_time_tick_hour(total_hours: int)

func _ready() -> void:
	set_initial_time()

func _process(delta: float) -> void:
	time += delta * game_speed * GMAE_MINUTES_DURATION
	game_time.emit(time)
	recalculate_time()

func set_initial_time()-> void:
	var intial_total_minutes = initial_day * MINUTES_PER_DAY + (initial_hour * MINUTES_PER_HOUR) + initial_minute
	
	time = intial_total_minutes * GMAE_MINUTES_DURATION

func recalculate_time() -> void:
	var total_minutes:int = int(time/GMAE_MINUTES_DURATION)
	var total_hours:int = int(total_minutes/MINUTES_PER_HOUR)

	var day:int = int(total_minutes/MINUTES_PER_DAY)
	var current_day_minutes:int = total_minutes%MINUTES_PER_DAY
	var hour:int = int(current_day_minutes/MINUTES_PER_HOUR)
	var minutes:int = int(current_day_minutes%MINUTES_PER_HOUR)

	if current_minutes != minutes:
		current_minutes = minutes
		time_tick.emit(day,hour,minutes)

	if current_hour != hour:
		current_hour = hour
		game_time_tick_hour.emit(total_hours)
		
	if current_day != day:
		current_day = day
		time_tick_day.emit(day)
