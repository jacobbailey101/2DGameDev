extends AudioStreamPlayer

const JUMP = preload("res://Sound/jump (1).wav")

@onready var audioPlayers = $AudioPlayers

func play_sound(sound):
	for audioStreamPlayer in audioPlayers.get_children():
		if not audioStreamPlayer.playing:
			audioStreamPlayer.stream = sound
			audioStreamPlayer.play(add_child)
			break
			
