class_name ItemTemplate
extends Sprite2D
@onready var collectable_componment: CollectableComponment = $CollectableComponment

@export var collectable_name: String
@export var stack_size: int = 1

func _ready() -> void:
	collectable_componment.collectable_name = collectable_name
	collectable_componment.stack_size = stack_size

func drop_from_inventory(item:InventoryItem)->void:
	var path = item.get_property("image")
	texture = load(path)
	collectable_name = item.get_prototype().get_id();
	stack_size = item.get_stack_size()
