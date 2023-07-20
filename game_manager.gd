extends Node

var checkpoint
@onready var player = get_node("/root/World/Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func set_checkpoint(c):
	checkpoint = c

func move_to_checkpoint():
	if checkpoint:
		player.global_position = checkpoint.global_position
	else:
		get_tree().reload_current_scene()
	
