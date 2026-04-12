@tool
class_name Player1 extends Player

@onready var hsm: LimboHSM = $LimboHSM
@onready var idle: LimboState = $LimboHSM/Idle
@onready var walk: LimboState = $LimboHSM/Walk
@onready var slash: LimboState = $LimboHSM/Slash
@onready var hurt: LimboState = $LimboHSM/Hurt
@onready var dead: LimboState = $LimboHSM/Dead
@onready var chopping: LimboState = $LimboHSM/Chopping
@onready var tilling: LimboState = $LimboHSM/Tilling
@onready var watering: LimboState = $LimboHSM/Watering


@export var blood_max:int = 100
@export var blood:int = 2

# How fast the player will move (pixels/sec).
@export var SPEED:int = 100
@export var ACCELERATION:float = SPEED/0.2
@export var eventHandleEnable: bool = true
@export var bodyTexture: Texture2D:
	set(v):
		bodyTexture = v
		%Body.texture = v
@export var weaponTexture: int = 0:
	set(v):
		weaponTexture = v
		%Weapon.texture = v

var current_tool: InventoryItem

var directionAngle = 0.0;
var lastGetHurtPosition:Vector2 = Vector2.ZERO


func on_tool_selected(tool: InventoryItem) -> void:
	current_tool = tool
	%HitBox.current_tool = tool
	var image = Global.get_item_hand_image(tool)
	var hasHandle = Global.get_item_has_handle(tool)
	if hasHandle:
		%Weapon.visible = true
		%Weapon.texture = image
		%Item.visible = false
	else:
		%Item.visible = true
		%Item.texture = image
		%Weapon.visible = false


func _ready():
	_init_state_machine()
	#%HitBox.Damaged.connect(takeDamage)
	ToolManager.tool_selected.connect(on_tool_selected)


func _init_state_machine() -> void:
	hsm.add_transition(idle, walk, idle.EVENT_FINISHED)
	hsm.add_transition(walk, idle, walk.EVENT_FINISHED)
	hsm.add_transition(idle, slash, "slash")
	hsm.add_transition(walk, slash, "slash")
	hsm.add_transition(slash, walk, slash.EVENT_FINISHED)
	hsm.add_transition(hsm.ANYSTATE, hurt, "hurt")
	hsm.add_transition(hsm.ANYSTATE, dead, "dead")
	hsm.add_transition(hurt, idle, hurt.EVENT_FINISHED)

	hsm.add_transition(idle, chopping, "chopping")
	hsm.add_transition(chopping, idle, chopping.EVENT_FINISHED)

	hsm.add_transition(idle, tilling, "tilling")
	hsm.add_transition(tilling, idle, tilling.EVENT_FINISHED)

	hsm.add_transition(idle, watering, "watering")
	hsm.add_transition(watering, idle, watering.EVENT_FINISHED)
	
	hsm.initialize(self)
	hsm.set_active(true)

func faceToMouse():
	directionAngle =global_position.direction_to(get_global_mouse_position()).angle()

func moveAndFaceToDirrection(dir:Vector2, delta: float):
	velocity.x = move_toward(velocity.x, dir.x * SPEED, ACCELERATION*delta)
	velocity.y = move_toward(velocity.y, dir.y * SPEED, ACCELERATION*delta)
	directionAngle  = dir.angle()
	move_and_slide()

func moveBackAndFromLastHurtPosition(delta: float):
	var dir = lastGetHurtPosition.direction_to(global_position)
	velocity.x = move_toward(velocity.x, dir.x * SPEED, ACCELERATION*delta)
	velocity.y = move_toward(velocity.y, dir.y * SPEED, ACCELERATION*delta)
	directionAngle  = (dir*-1).angle()
	move_and_slide()

func playSkill():
	print("playSkill")
	#var fire_ball_tscn = preload("res://scenes/objects/projectiles/fire_ball.tscn")
	#var fireBall = fire_ball_tscn.instantiate()
	#fireBall.directionAngle = directionAngle
#
	#var direction = Vector2.from_angle(fireBall.directionAngle) *50
#
	#fireBall.position.x = position.x +  direction.x
	#fireBall.position.y = position.y +  direction.y
	#get_parent().add_child(fireBall)

func playSlashSkill():
	print("slash")

	pass



#func takeDamage(_damage:int, hitPostion:Vector2) -> void:
	#lastGetHurtPosition = hitPostion
	#blood = blood - _damage
	#print("take damage", _damage, blood)
	#if blood <= 0 and hsm.get_active_state() != dead:
		#print("idel process to dead")
		#hsm.dispatch("dead")
	#else :
		#hsm.dispatch("hurt")
