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
		#SAVING STUFF
		var player_loadout = get_node("/root/PlayerLoadout")
		SaveGame.new().write_savegame(player_loadout.weapons, player_loadout.legs, player_loadout.boosters, player_loadout.weapon.id, player_loadout.booster.id, player_loadout.leg.id, player_loadout.cash)
		
		get_tree().quit()
