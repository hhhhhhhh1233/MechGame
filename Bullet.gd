extends CharacterBody3D


const SPEED = 15.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	await get_tree().create_timer(10.0).timeout
	queue_free()

func _physics_process(delta):
	position += global_transform.basis.z * -SPEED * delta
	move_and_slide()
