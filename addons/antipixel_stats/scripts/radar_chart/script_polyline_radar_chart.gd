@tool
class_name PolylineRadarChart extends RadarChart

@export var width: int = -1
@export var antialiased: bool

func _draw() -> void:
	if not calculate(): return
	draw_polyline(points, color, width, antialiased)
