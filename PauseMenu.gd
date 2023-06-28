extends PopupMenu

func _on_id_pressed(id):
	get_tree().paused = false
	$"../PauseText".hide()
	if id == 1:
		get_tree().change_scene_to_file("res://control.tscn")
	if id == 2:
		get_tree().quit()
