extends PopupMenu

func _on_id_pressed(id):
	get_tree().paused = false
	$"../PauseText".hide()
	if id == 0:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if id == 1:
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	if id == 2:
		get_tree().quit()
