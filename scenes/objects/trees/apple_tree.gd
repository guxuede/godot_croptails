extends Sprite2D
@onready var apple_hurt_compoment: HurtCompoment = $HurtCompoment
@onready var apple_damage_compoment: DamageCompoment = $DamageCompoment

var log_sence = preload("res://scenes/objects/trees/log.tscn")

func _ready() -> void:
	apple_hurt_compoment.hurt.connect(apple_on_hurt)
	apple_damage_compoment.max_damaged_reached.connect(on_apple_tree_max_damaged_reached)

func apple_on_hurt(hit_damage: int) -> void:
	apple_damage_compoment.apply_damage(hit_damage)
	print(material)
	material.set_shader_parameter("shake_intensity",3.0)
	await get_tree().create_timer(1.0).timeout
	material.set_shader_parameter("shake_intensity",0.0)


func on_apple_tree_max_damaged_reached() -> void:
	call_deferred("add_log_scenes")
	print("mx damaged reacched")
	queue_free()
	
func add_log_scenes() -> void:
	var log_obj = log_sence.instantiate() as Node2D
	log_obj.global_position = global_position
	get_parent().add_child(log_obj)
