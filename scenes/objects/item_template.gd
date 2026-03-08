class_name ItemTemplate
extends Sprite2D
@onready var collectable_componment: CollectableComponment = $CollectableComponment

@export var collectable_name: String
@export var stack_size: int = 1

var time: float
var amplitude :float= 3.0
var frequency :float= 3.0
@onready var default_pos = get_position()

func _ready() -> void:
	collectable_componment.collectable_name = collectable_name
	collectable_componment.stack_size = stack_size

func _physics_process(delta: float) -> void:
	time += delta * frequency
	set_position(default_pos + Vector2(0, sin(time) * amplitude))

func drop_from_inventory(item:InventoryItem)->void:
	var path = item.get_property("image")
	texture = load(path)
	collectable_name = item.get_prototype().get_id();
	stack_size = item.get_stack_size()
