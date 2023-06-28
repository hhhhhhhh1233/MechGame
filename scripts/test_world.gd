extends Node3D

var player_loadout
# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect2/Label.text = "%d left" % $Enemies.get_child_count()
	player_loadout = get_node("/root/PlayerLoadout")
	get_tree().paused = true
	await get_tree().create_timer(1).timeout
	$ColorRect.hide()
	get_tree().paused = false

func _process(_delta):
	if $Enemies.get_child_count() == 0:
		$ColorRect.show()
		$ColorRect/Label.text = "you win"
		await get_tree().create_timer(3).timeout
		player_loadout.cash += 100
		Input.stop_joy_vibration(0)
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	$ColorRect2/Label.text = "%d left" % $Enemies.get_child_count()
