extends Node2D
class_name FruitTreeTemplate


var log_sence = preload("res://scenes/objects/trees/log.tscn")
var item_template = preload("res://scenes/objects/item_template.tscn")

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var watering_partices: GPUParticles2D = $WateringPartices
@onready var flowering_partices: GPUParticles2D = $FloweringPartices
@onready var growth_cycle_compoment: FruitTreeGrowthCycleCompoment = $FruitsTreeGrowthCycleCompoment
@onready var hurt_compoment: HurtCompoment = $HurtCompoment
@onready var damage_compoment: DamageCompoment = $DamageCompoment
@onready var inventory: Inventory = $Inventory


func _ready() -> void:
	watering_partices.emitting = false
	flowering_partices.emitting = false
	
	hurt_compoment.hurt_with_item.connect(on_hurt_with_item)
	growth_cycle_compoment.growthStateChanged.connect(on_growthStateChanged)
	growth_cycle_compoment.growthStatePeriodChanged.connect(on_growthStatePeriodChanged)
	damage_compoment.max_damaged_reached.connect(on_apple_tree_max_damaged_reached)



#func _process(delta: float) -> void:
	#sprite_2d.frame = growth_cycle_compoment.get_current_growth_frame()

func on_hurt_with_item(hit_damage:int, item:InventoryItem) -> void:
	var growth_state = growth_cycle_compoment.current_growth_state
	if Global.get_item_id(item) == "tool_watering":
		watering_partices.emitting = true
		await get_tree().create_timer(5.0).timeout
		watering_partices.emitting = false 
		growth_cycle_compoment.growth_speed_rate = hit_damage

	if Global.get_item_id(item) == "tool_axe":
		if growth_state == DatTypes.GrowthStates.Maturity:
			drop_havest_scenes()
			growth_cycle_compoment.back_to_vegetative_status()
			sprite_2d.material.set_shader_parameter("shake_intensity",3.0)
			await get_tree().create_timer(1.0).timeout
			sprite_2d.material.set_shader_parameter("shake_intensity",0.0)
		elif growth_state >= DatTypes.GrowthStates.Vegetative:
			damage_compoment.apply_damage(hit_damage)
			sprite_2d.material.set_shader_parameter("shake_intensity",3.0)
			await get_tree().create_timer(1.0).timeout
			sprite_2d.material.set_shader_parameter("shake_intensity",0.0)

func on_growthStateChanged(p:DatTypes.GrowthStates) -> void:
	if p == DatTypes.GrowthStates.Maturity:
		flowering_partices.emitting = true
		hurt_compoment.tool = "tool_axe"
	else:
		flowering_partices.emitting = false

func on_growthStatePeriodChanged(p:GrowthStatePeriod) -> void:
	sprite_2d.frame = p.current_growth_frame

func on_apple_tree_max_damaged_reached() -> void:
	drop_log_scenes()
	print("mx damaged reacched")
	queue_free()

func drop_log_scenes() -> void:
	var log_obj = log_sence.instantiate() as Node2D
	log_obj.global_position = global_position
	get_parent().add_child(log_obj)

func drop_havest_scenes() -> void:
	var items = inventory.get_items()
	for i in items:
		var itemTemplate = item_template.instantiate() as ItemTemplate
		itemTemplate.drop_from_inventory(i)
		itemTemplate.global_position = global_position + Vector2(randf_range(-20,20),randf_range(-20,20))
		get_parent().add_child(itemTemplate)
