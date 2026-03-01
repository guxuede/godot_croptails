@tool
class_name RadarChart extends Control

const ROTATION_OFFSET: float = -PI * 0.5

@export var data: Array[float]:
	set(value): data = value; queue_redraw()
@export var color: Color = Color.WHITE:
	set(value): color = value; queue_redraw()

var points: Array[Vector2]

func _draw() -> void:
	if not calculate(): return
	draw_polygon(points, [color])

func calculate() -> bool:
	points.clear()
	
	var sides: int = data.size()
	if sides < 3:
		push_warning("A polygon must have at least 3 sides.")
		return false
	
	var angle_step: float = TAU / sides
	var position_offset: Vector2 = size * 0.5
	var angle: float
	for i: int in sides:
		angle = i * angle_step + ROTATION_OFFSET
		points.append(Vector2(cos(angle), sin(angle)) \
		* size.y * 0.5 \
		* data[i] \
		+ position_offset)
	
	points.append(points[0])
	return true
