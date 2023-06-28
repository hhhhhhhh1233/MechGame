extends PopupMenu

func _process(_delta):
	await get_tree().create_timer(2).timeout
	if Input.is_action_just_pressed("pause") and get_tree().paused == true:
		get_tree().paused = false
		$"../PauseText".hide()
		hide()

func _on_id_pressed(id):
	get_tree().paused = false
	$"../PauseText".hide()
	if id == 1:
		get_tree().change_scene_to_file("res://control.tscn")
	if id == 2:
		get_tree().quit()
