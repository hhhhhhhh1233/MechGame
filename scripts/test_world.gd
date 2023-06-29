extends Node3D

var player_loadout
# Called when the node enters the scene tree for the first time.
func _ready():
	$WinCondition/Label.text = "%d left" % $Enemies.get_child_count()
	$Player.died.connect(_player_died)
	player_loadout = get_node("/root/PlayerLoadout")
	get_tree().paused = true
	await get_tree().create_timer(1).timeout
	$Message.hide()
	get_tree().paused = false

func _process(_delta):
	$WinCondition/Label.text = "%d left" % $Enemies.get_child_count()
	if $Enemies.get_child_count() == 0:
		$Message.show()
		$Message/Label.text = "you win ($%d)" % int(100 - player_loadout.debt)
		await get_tree().create_timer(3).timeout
		player_loadout.cash += int(100 - player_loadout.debt)
		player_loadout.debt = 0
		Input.stop_joy_vibration(0)
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _player_died():
	$Message.show()
	$Message/Label.text = "you lost ($%d)" % (0.1*player_loadout.cash + player_loadout.debt)
	await get_tree().create_timer(3).timeout
	player_loadout.cash *= 0.9
	player_loadout.cash -= player_loadout.debt
	player_loadout.debt = 0
	Input.stop_joy_vibration(0)
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
