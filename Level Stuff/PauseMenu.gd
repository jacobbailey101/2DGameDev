extends Control

var is_paused = false: 
	set(value):
		is_paused = value
		get_tree().paused = is_paused
		visible = is_paused

func _ready():
	self.is_paused = false
	
func _input(event):
	if event.is_action_pressed("pause"):
		self.is_paused = !is_paused


func _on_resume_pressed():
	self.is_paused = false


func _on_quit_pressed():
	get_tree().quit()
