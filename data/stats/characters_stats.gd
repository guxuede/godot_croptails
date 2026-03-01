class_name CharactersStats
extends Node

@export var stats: Array[Stat]
var stats_map:Dictionary

func _ready() -> void:
	for v in stats:
		stats_map[v.id] = v

func get_stat(stat_id:String) -> Stat:
	return stats_map[stat_id]

func add_mod(stat_id:String, statModifier:StatModifier) -> Stat:
	return stats_map[stat_id].add_mod(statModifier)

func remove_mod(stat_id:String, statModifier:StatModifier) -> void:
	return stats_map[stat_id].remove_mod(statModifier)
