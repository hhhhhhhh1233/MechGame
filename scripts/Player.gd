extends CharacterBody3D


const SPEED = 7.5
const JUMP_VELOCITY = 6
const JUMP_ACCEL = 0.1
const LOOK_SPEED = 2
const LOOK_ANGLE = 0.8
const WEIGHT = 0.3
const SHOOT_DELAY = 0.1

var health = 100

var shooting = false
@onready var BULLET = preload("res://bullet.tscn")
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	#print(health)
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_pressed("shoot"):
		if not shooting:
			shooting = true
			var bullet =  BULLET.instantiate()
			#$"..".add_child(bullet)
			$Gun.add_child(bullet)
			#bullet.transform = $Gun.transform
			#bullet.position += bullet.global_transform.basis.z * -1
			Input.start_joy_vibration(0, 0.1, 0)
			await get_tree().create_timer(SHOOT_DELAY).timeout
			Input.stop_joy_vibration(0)
			shooting = false

	if Input.is_action_just_pressed("pause"):
		get_tree().quit()

	# Handle Jump.
	if Input.is_action_pressed("fly"):
		Input.start_joy_vibration(0, 0, 0.1, 0.2)
		velocity.y += JUMP_VELOCITY * JUMP_ACCEL - WEIGHT
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

func decreaseHealth(amount):
	health -= amount
	if health <= 0:
		get_tree().reload_current_scene()
