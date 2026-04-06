extends AudioStreamPlayer2D

@export var player: Player1

const footstep_sounds = {
	"dirt": [
		preload("res://assets/audio/sfx/dirt_1.wav"),
		preload("res://assets/audio/sfx/dirt_2.wav"),
		preload("res://assets/audio/sfx/dirt_3.wav"),
	],
	"grass": [
		preload("res://assets/audio/sfx/grass_1.wav"),
		preload("res://assets/audio/sfx/grass_2.wav"),
		preload("res://assets/audio/sfx/grass_3.wav"),
	],
	"snow": [
		preload("res://assets/audio/sfx/snow_1.wav"),
		preload("res://assets/audio/sfx/snow_2.wav"),
		preload("res://assets/audio/sfx/snow_3.wav"),
	]
}


func _play_footstep():
	var ground_type = FootSoundManager.get_ground_type_under_character(player.global_position)
	if footstep_sounds.has(ground_type) and footstep_sounds[ground_type]:
		self.stream = footstep_sounds[ground_type].pick_random()
		self.global_position = player.global_position
		# 随机调整音量/音调，让脚步声更自然
		self.volume_db = randf_range(-2, 0) # 音量轻微随机
		self.pitch_scale = randf_range(0.9, 1.1) # 音调轻微随机
		self.play()
	pass
