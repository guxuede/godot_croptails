class_name FruitTreeGrowthCycleCompoment
extends Node2D

@export var growth_speed_rate: int = 1
@export var growthStatePeriod: Array[GrowthStatePeriod]
@export var currentGrowthStatePeriodIndex: int = 0
@export var VegetativeGrowthStatePeriodIndex: int = 2

var starting_hour: int
var current_growth_state_starting_hour:int




var current_growth_frame: int = 0
var current_growth_state: DatTypes.GrowthStates = DatTypes.GrowthStates.Germination
	#Germination, 	# 0 发芽
	#Vegetative,	# 1 植物
	#Reproduction,	# 2 开花
	#Maturity		# 3 结果

signal plant_maturity()
signal growthStateChanged(p:DatTypes.GrowthStates)
signal growthStatePeriodChanged(p:GrowthStatePeriod)


func _ready() -> void:
	DayAndNightManager.game_time_tick_hour.connect(game_time_tick_hour)
	current_growth_state = growthStatePeriod[currentGrowthStatePeriodIndex].current_growth_state
	current_growth_frame = growthStatePeriod[currentGrowthStatePeriodIndex].current_growth_frame

func game_time_tick_hour(totalHour:int) -> void:
	#if is_watered:
	if starting_hour == 0:
		starting_hour = totalHour


	if current_growth_state_starting_hour == 0:
		current_growth_state_starting_hour = totalHour

	var hours_passed = (totalHour- starting_hour)*growth_speed_rate
	var current_growth_state_hours_passed = (totalHour- current_growth_state_starting_hour)*growth_speed_rate
	
	if currentGrowthStatePeriodIndex < growthStatePeriod.size()-1:
		if current_growth_state_hours_passed >= growthStatePeriod[currentGrowthStatePeriodIndex].hours_to_next_state:
			var preGrowthStatePeriodIndex = currentGrowthStatePeriodIndex
			currentGrowthStatePeriodIndex+=1
			current_growth_state_starting_hour = totalHour
			on_GrowthPeriod_changed(preGrowthStatePeriodIndex)
			growthStatePeriodChanged.emit(growthStatePeriod[currentGrowthStatePeriodIndex])
			print("FruitTreeGrowthCycleCompoment:  state index:", current_growth_state, "current_growth_state:", DatTypes.GrowthStates.keys()[current_growth_state], ", hours_passed:", hours_passed)

	
func on_GrowthPeriod_changed(preGrowthStatePeriodIndex: int) -> void:
	var prePeriod = growthStatePeriod[preGrowthStatePeriodIndex]
	var newPeriod = growthStatePeriod[currentGrowthStatePeriodIndex]

	current_growth_frame = newPeriod.current_growth_frame #frame changing

	var preState = current_growth_state
	var newState = newPeriod.current_growth_state
	if newState != current_growth_state:
		current_growth_state = newState #state changing
		growthStateChanged.emit(current_growth_state)
		if(newState > preState):
			if current_growth_state == DatTypes.GrowthStates.Maturity:
				plant_maturity.emit()

func back_to_vegetative_status():
	var preGrowthStatePeriodIndex = currentGrowthStatePeriodIndex
	current_growth_state_starting_hour = 0
	currentGrowthStatePeriodIndex = VegetativeGrowthStatePeriodIndex
	on_GrowthPeriod_changed(preGrowthStatePeriodIndex)
	growthStatePeriodChanged.emit(growthStatePeriod[currentGrowthStatePeriodIndex])

func get_current_growth_frame() -> int:
	return current_growth_frame
	
	
	
	
	
	
	
