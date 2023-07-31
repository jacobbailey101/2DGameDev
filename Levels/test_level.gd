extends Node

var level_time = 0.0
var start_level_msec = 0.0

@onready var level_time_label = %LevelTimeLabel

func _ready():
	start_level_msec = Time.get_ticks_msec()
	
func _process(delta):
	level_time = Time.get_ticks_msec() - start_level_msec
	level_time_label.text = "%.2f" % [level_time / 1000.0] 
	#print("Number %.2f" % [1.4565])
