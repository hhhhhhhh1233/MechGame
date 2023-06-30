extends Legs
class_name Hovercraft

func _init():
	id = 2
	name = "Hovercraft"
	owned = false
	speed = 10
	weight = 0.2
	jump_velocity = 4
	
func walk(player):
	var input_dir = Input.get_vector("walk_left", "walk_right", "walk_forward", "walk_back")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		player.velocity.x = direction.x * speed
		player.velocity.z = direction.z * speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, 0.1)
		player.velocity.z = move_toward(player.velocity.z, 0, 0.1)
