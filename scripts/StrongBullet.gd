extends RigidBody3D


const SPEED = 100.0
const DAMAGE = 5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	top_level = true
	add_constant_central_force(transform.basis.z * SPEED)
	await get_tree().create_timer(10.0).timeout
	queue_free()

func changeDirection(dir):
	constant_force = Vector3.ZERO
	add_constant_central_force(dir * SPEED)

func _on_area_3d_body_entered(body):
	if body.collision_layer == 2 or body.collision_layer == 4:
		body.decreaseHealth(DAMAGE)

	queue_free()
