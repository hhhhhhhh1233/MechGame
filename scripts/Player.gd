extends CharacterBody3D


const SPEED = 10.0
const JUMP_VELOCITY = 6
const JUMP_ACCEL = 0.1
const LOOK_SPEED = 3
const LOOK_ANGLE = 0.8

@onready var BULLET = preload("res://bullet.tscn")
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
		
	if Input.is_action_just_pressed("shoot"):
		var bullet =  BULLET.instantiate()
		$"..".add_child(bullet)
		bullet.transform = transform
		bullet.position += bullet.global_transform.basis.z * -1

	if Input.is_action_just_pressed("pause"):
		get_tree().quit()

	# Handle Jump.
	if Input.is_action_pressed("fly"):
		velocity.y += JUMP_VELOCITY * JUMP_ACCEL
		if velocity.y > JUMP_VELOCITY:
			velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("walk_left", "walk_right", "walk_forward", "walk_back")
	var look_dir = Input.get_vector("look_left","look_right", "look_up", "look_down")
	
	if look_dir:
		rotation.x += -look_dir.y * delta * LOOK_SPEED
		if rotation.x > LOOK_ANGLE:
			rotation.x = LOOK_ANGLE
		if rotation.x < -LOOK_ANGLE:
			rotation.x = -LOOK_ANGLE
		rotation.y += -look_dir.x * delta * LOOK_SPEED
	
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()