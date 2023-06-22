extends RigidBody3D


const SPEED = 50.0
const DAMAGE = 2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	top_level = true
	set_axis_velocity(transform.basis.z * SPEED)
	await get_tree().create_timer(10.0).timeout
	queue_free()

#func _physics_process(delta):
	
	#apply_impulse(transform.basis.z, -transform.basis.z * SPEED)
#	position += global_transform.basis.z * -SPEED * delta
#	move_and_slide()


func _on_area_3d_body_entered(body):
	print("HIT")
	if body.collision_layer == 2 or body.collision_layer == 4:
		body.decreaseHealth(DAMAGE)

	queue_free()
