extends RigidBody3D


const SPEED = 50.0
const DAMAGE = 5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	top_level = true
	add_constant_central_force(transform.basis.z * SPEED)
	#set_axis_velocity(transform.basis.z * SPEED)
	await get_tree().create_timer(10.0).timeout
	queue_free()

#func _physics_process(delta):
	
	#apply_impulse(transform.basis.z, -transform.basis.z * SPEED)
#	position += global_transform.basis.z * -SPEED * delta
#	move_and_slide()

func changeDirection(dir):
	#set_axis_velocity(dir)
	constant_force = Vector3.ZERO
	add_constant_central_force(dir * SPEED)

func _on_area_3d_body_entered(body):
	if body.has_method("decreaseHealth"):
		body.decreaseHealth(DAMAGE)

	queue_free()


func _on_area_3d_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if area.get_parent().has_method("decreaseHealth"):
		area.get_parent().decreaseHealth(DAMAGE)

	queue_free()
