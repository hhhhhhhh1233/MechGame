class_name Legs

var id: int
var name: String
var owned: bool
var speed: float
var weight: float
var jump_velocity: float

func _init(i: int, n: String, o: bool, s: float, w: float, jv: float):
	id = i
	name = n
	owned = o
	speed = s
	weight = w
	jump_velocity = jv

func walk(player):
	var input_dir = Input.get_vector("walk_left", "walk_right", "walk_forward", "walk_back")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		player.velocity.x = direction.x * speed
		player.velocity.z = direction.z * speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)
		player.velocity.z = move_toward(player.velocity.z, 0, speed)
