extends Node

const STATS:Dictionary = {
	"MaxHealth": &"MaxHealth",
	"Health": &"Health",
	"Strength": &"Strength",
	"WateringDamage": &"WateringDamage",
	"MaxWateringDamage": &"MaxWateringDamage",
}

func await_timer(_time:float) -> void:
	await get_tree().create_timer(_time).timeout
