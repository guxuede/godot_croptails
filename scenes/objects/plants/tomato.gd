extends Node2D

var havest_scene = preload("res://scenes/objects/plants/tomato_harvest.tscn")

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var watering_partices: GPUParticles2D = $WateringPartices
@onready var flowering_partices: GPUParticles2D = $FloweringPartices
@onready var growth_cycle_compoment: GrowthCycleCompoment = $GrowthCycleCompoment
@onready var hurt_compoment: HurtCompoment = $HurtCompoment

var growth_state: DatTypes.GrowthStates = DatTypes.GrowthStates.Seed


func _ready() -> void:
	watering_partices.emitting = false
	flowering_partices.emitting = false
	
	hurt_compoment.hurt.connect(on_hurt)
	growth_cycle_compoment.crop_maturity.connect(on_crop_maturity)
	growth_cycle_compoment.crop_harvesting.connect(on_cropharvesting)


func _process(delta: float) -> void:
	growth_state = growth_cycle_compoment.get_current_growth_state()
	sprite_2d.frame = growth_state
	
	if growth_state == DatTypes.GrowthStates.Maturity:
		flowering_partices.emitting = true
	
func on_hurt(hit_damage:int) -> void:
	if !growth_cycle_compoment.is_watered:
		watering_partices.emitting = true
		await get_tree().create_timer(5.0).timeout
		watering_partices.emitting = false
		growth_cycle_compoment.is_watered = true

func on_crop_maturity() -> void:
	flowering_partices.emitting = true
		
func on_cropharvesting() -> void:
	var harvest_instance = havest_scene.instantiate() as Node2D
	harvest_instance.global_position = global_position
	get_parent().add_child(harvest_instance)
	queue_free()
