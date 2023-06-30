extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const SHOOT_DELAY = 1
@onready var BULLET = preload("res://scenes/strong_bullet.tscn")
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
#@onready var player = 
var health = 150
var player
var shooting = false

var playerDead = false

func _ready():
	player = get_node("/root/World/Player")
	player.died.connect(_player_died)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	if not playerDead:
		look_at(player.position)
		
	if not shooting and $RayCast3D.is_colliding():
		shooting = true
		var bullet = BULLET.instantiate()
		$Gun.add_child(bullet)
		#$"..".add_child(bullet)
		#bullet.transform = transform
		#bullet.position += bullet.global_transform.basis.z * -1
		await get_tree().create_timer(randf_range(0.3, 0.6)).timeout
		shooting = false
		
	move_and_slide()

func decreaseHealth(amount):
	health -= amount
	if health <= 0:
		Input.stop_joy_vibration(0)
		queue_free()
		
func _player_died():
	playerDead = true

func set_highlight(boo):
	if boo:
		$InSightHighlight.show()
	else:
		$InSightHighlight.hide()
