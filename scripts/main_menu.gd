extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Garage.grab_focus()



func _on_garage_pressed():
	get_tree().change_scene_to_file("res://scenes/control.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_bounty_1_pressed():
	get_tree().change_scene_to_file("res://scenes/test_world.tscn")


func _on_bounty_2_pressed():
	get_tree().change_scene_to_file("res://scenes/bridge_bounty.tscn")
