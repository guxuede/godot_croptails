extends Sprite2D
@onready var hurt_compoment: HurtCompoment = $HurtCompoment
@onready var damage_compoment: DamageCompoment = $DamageCompoment

var log_sence = preload("res://scenes/objects/trees/log.tscn")
func _ready() -> void:
	hurt_compoment.hurt.connect(on_hurt)
	damage_compoment.max_damaged_reached.connect(on_max_damaged_reached)

func on_hurt(hit_damage: int) -> void:
	damage_compoment.apply_damage(hit_damage)
	print(material)
	material.set_shader_parameter("shake_intensity",3.0)
	await get_tree().create_timer(1.0).timeout
	material.set_shader_parameter("shake_intensity",0.0)


func on_max_damaged_reached() -> void:
	call_deferred("add_log_scenes")
	print("mx damaged reacched")
	queue_free()
	
func add_log_scenes() -> void:
	var log_obj = log_sence.instantiate() as Node2D
	log_obj.global_position = global_position
	get_parent().add_child(log_obj)
