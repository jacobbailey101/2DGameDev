extends Area2D

@export_file("*.tscn") var target_level_path = ""


func _on_body_entered(body):
	if not body is Player: return
	if target_level_path.is_empty(): return
	get_tree().paused = true
	await Transistions.fade_to_black()
	get_tree().paused = false
	get_tree().change_scene_to_file(target_level_path)
	Transistions.fade_from_black()
