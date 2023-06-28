extends Camera3D

var dead = false

func _ready():
	$"../Player".died.connect(_player_died)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not dead:
		position = lerp(position, $"../Player/SpringArm3D/CameraTarget".global_position, 0.2)
	#transform.basis = Quaternion(transform.basis).slerp(Quaternion($"../Player/CameraTarget".transform), 0.2)
		rotation = $"../Player/SpringArm3D/CameraTarget".global_rotation
		rotation = lerp(rotation, $"../Player/SpringArm3D/CameraTarget".global_rotation, 0.2)
	#transform = lerp(transform, $"../Player/CameraTarget".transform, 0.2)

func _player_died():
	dead = true
