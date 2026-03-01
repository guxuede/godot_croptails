@tool
extends Control

@export var stats: Array[Stat]:
	set(value): stats = value; update()
@export var charts: Array[RadarChart]:
	set(value): charts = value; update()

@export_tool_button("Update")
var update_action: Callable = update

func _ready() -> void:
	for i: int in stats.size():
		stats[i].value_changed.connect(_on_value_changed)
	update()

func _on_value_changed() -> void:
	update()

func update() -> void:
	var data: Array[float]
	for stat: Stat in stats: data.append(stat.progress)
	for chart: RadarChart in charts: chart.data = data
