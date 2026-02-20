extends NodeState

@export var character: NonPlayableCharacter
@export var animated_sprite_2d: AnimatedSprite2D
@export var idle_state_interval: float = 5.0

@onready var idle_state_timer: Timer = Timer.new()

var idle_state_timer_out: bool = true

func _ready() -> void:
	idle_state_timer.wait_time = idle_state_interval
	idle_state_timer.timeout.connect(on_idle_state_timer_timeout)
	add_child(idle_state_timer)

func on_process(_delta : float):
	pass


func on_physics_process(_delta : float):
	pass

func on_next_transitions(_delta : float):
	if idle_state_timer_out:
		transition.emit("Walk")

func on_enter():
	animated_sprite_2d.play("idle")
	idle_state_timer_out = false
	idle_state_timer.start()

func on_exit():
	animated_sprite_2d.stop()
	idle_state_timer.stop()


func on_idle_state_timer_timeout() -> void:
	idle_state_timer_out = true
