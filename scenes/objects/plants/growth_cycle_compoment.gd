class_name GrowthCycleCompoment
extends Node2D

@export var current_growth_state: DatTypes.GrowthStates = DatTypes.GrowthStates.Germination
@export var growth_speed_rate: int = 1

@export var num_states_to_maturity:int = 4 #生长阶段,对于的帧
@export_range(5, 365) var hours_per_states_until_maturity: int = 5
@export_range(5, 365) var hours_from_maturity_until_harvest: int = 10



signal crop_maturity
signal crop_harvesting

var starting_hour: int
var is_harvestable: bool

func _ready() -> void:
	DayAndNightManager.game_time_tick_hour.connect(game_time_tick_hour)


func game_time_tick_hour(totalHour:int) -> void:
	#if is_watered:
	if starting_hour == 0:
		starting_hour = totalHour

	var hours_passed = (totalHour- starting_hour)*growth_speed_rate
	
	if current_growth_state < DatTypes.GrowthStates.Maturity:
		var growth_state = min(hours_passed / hours_per_states_until_maturity, num_states_to_maturity-1)
		if current_growth_state != growth_state:
			current_growth_state = growth_state
			print("GrowthCycleCompoment: ", DatTypes.GrowthStates.keys()[current_growth_state], ", state:", current_growth_state, ", hours_passed:", hours_passed)
			if current_growth_state >= DatTypes.GrowthStates.Maturity:
				crop_maturity.emit()

	if current_growth_state == DatTypes.GrowthStates.Maturity && not is_harvestable:
		var hours_passed_after_maturity = hours_passed - (hours_per_states_until_maturity * num_states_to_maturity)
		if  hours_passed_after_maturity >= hours_from_maturity_until_harvest:
			is_harvestable = true
			print("is_harvestable, hours_passed_after_maturity", hours_passed_after_maturity)
			crop_harvesting.emit()
	
	

func get_current_growth_state() -> DatTypes.GrowthStates:
	return current_growth_state
	
	
	
	
	
	
	
