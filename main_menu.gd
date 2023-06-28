extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Garage.grab_focus()



func _on_garage_pressed():
	get_tree().change_scene_to_file("res://control.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_bounty_1_pressed():
	get_tree().change_scene_to_file("res://test_world.tscn")
