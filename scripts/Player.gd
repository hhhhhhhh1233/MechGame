extends CharacterBody3D

signal died

var JUMP_VELOCITY = 6
var LOOK_SPEED = 2
var LOOK_ANGLE = 0.8
var WEIGHT = 0.3
var SHOOT_DELAY: float

var sensitivity = 0.0005

var health = 500

var shooting = false
var ammo = 300

#@onready var BULLET = preload("res://bullet.tscn")
#@onready var STRONG_BULLET = preload("res://strong_bullet.tscn")

#var BULLET

var player_loadout

var weapon
var booster
var leg

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	player_loadout = get_node("/root/PlayerLoadout")
	
	SHOOT_DELAY = player_loadout.weapon.shoot_delay
	
	weapon = player_loadout.weapon
	booster = player_loadout.booster
	leg = player_loadout.leg
	
	var sphere = SphereShape3D.new()
	sphere.radius = weapon.autoRange
	$AutoAimRange/CollisionShape3D.shape = sphere
	
	JUMP_VELOCITY = player_loadout.leg.jump_velocity
	
	WEIGHT = player_loadout.leg.weight + player_loadout.booster.weight + player_loadout.weapon.weight
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
		
	if Input.is_action_just_pressed("jump") and $RayCast3D.is_colliding():
		velocity.y = JUMP_VELOCITY
		$RayCast3D.enabled = false
		await get_tree().create_timer(0.2).timeout
		$RayCast3D.enabled = true
	
	var enemiesInRange = $AutoAimRange.get_overlapping_bodies()
	var enemiesInSight = []
	for enemy in enemiesInRange:
		$AimDetectionRay.global_position = $SpringArm3D/CameraTarget.global_position
		$AimDetectionRay.look_at(enemy.position)
		$AimDetectionRay.force_raycast_update()
		if $AimDetectionRay.is_colliding():
			enemiesInSight.append(enemy)
			enemy.set_highlight(true)
		else:
			enemy.set_highlight(false)
	
	var shortest
	if enemiesInSight:
		shortest = enemiesInSight[0]
		for i in enemiesInSight:
			if Vector3($Gun.global_position - i.global_position).length() < Vector3($Gun.global_position - shortest.global_position).length():
				shortest = i
		$EnemyHighlight.global_position = shortest.global_position + Vector3(0,2,0)
		shortest.set_highlight(false)
		$EnemyHighlight.show()
	else:
		$EnemyHighlight.hide()
	
	if Input.is_action_pressed("shoot"):
		if not shooting and ammo > 0:
			shooting = true
			weapon.shoot($Gun, enemiesInSight, shortest)
			Input.start_joy_vibration(0, 0.1, 0)
			await get_tree().create_timer(SHOOT_DELAY).timeout
			ammo -= 1
			player_loadout.debt += 0.1
			Input.stop_joy_vibration(0)
			shooting = false

	if Input.is_action_just_pressed("pause"):
		get_tree().paused = true
		$"../PauseText".show()
		$"../PauseMenu".show()
		$"../PauseMenu".set_focused_item(0)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if Input.is_action_pressed("fly"):
		player_loadout.debt += delta
		booster.boost(self, $RayCast3D)
		Input.start_joy_vibration(0, 0, 0.1, 0.2)
	if Input.is_action_just_released("fly"):
		booster.releaseBoost(self, $RayCast3D)

	var look_dir = Input.get_vector("look_left","look_right", "look_up", "look_down")
	
	if look_dir:
		rotation.x += -look_dir.y * delta * LOOK_SPEED
		if rotation.x > LOOK_ANGLE:
			rotation.x = LOOK_ANGLE
		elif rotation.x < -LOOK_ANGLE:
			rotation.x = -LOOK_ANGLE
		else:
			$RayCast3D.rotation.x -= -look_dir.y * delta * LOOK_SPEED
		rotation.y += -look_dir.x * delta * LOOK_SPEED
	
	if $RayCast3D.is_colliding():
		var springStrength = 15
		var springDamping = 5
		
		var x = 3
		var length = Vector3($RayCast3D.get_collision_point() - position).length()
		var offset = x - length
		
		velocity.y += (springStrength * offset - velocity.y * springDamping) * delta
	
	leg.walk(self)
	
	$"../Ammo/Label".text = "ammo: %d" % ammo
	move_and_slide()

func decreaseHealth(amount):
	health -= amount
	if health <= 0:
		died.emit()
		queue_free()
		
func _input(event):
	if !visible:
		return
	if event is InputEventMouseMotion:
		rotation.x += event.relative.y * sensitivity * -1 * LOOK_SPEED
		if rotation.x > LOOK_ANGLE:
			rotation.x = LOOK_ANGLE
		if rotation.x < -LOOK_ANGLE:
			rotation.x = -LOOK_ANGLE
		rotation.y += event.relative.x * sensitivity * -1 * LOOK_SPEED


func _on_auto_aim_range_body_exited(body):
	body.set_highlight(false)
