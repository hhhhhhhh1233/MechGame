extends Weapon
class_name Shotgun

func _init():
	id = 2
	name = "Shotgun"
	owned = false
	bullet = preload("res://scenes/strong_bullet.tscn")
	shoot_delay = 0.5
	weight = 0.1
	autoRange = 15

func shoot(gun, enemiesInSight, closestEnemy):
	var bull = bullet.instantiate()
	var toEnemy
	var distance
	if closestEnemy:
		toEnemy = Vector3(closestEnemy.global_position - gun.global_position)
		distance = toEnemy.length() / 10
	else:
		toEnemy = Vector3(gun.global_transform.basis.z).normalized() * 30
		distance = 3
	gun.add_child(bull)
	if enemiesInSight:
		bull.changeDirection(toEnemy.normalized())
	for i in range(5):
		var b = bullet.instantiate()
		gun.add_child(b)
		b.changeDirection(Vector3(toEnemy + Vector3(randf_range(-distance,distance),randf_range(-distance,distance),randf_range(-distance,distance))).normalized())
		#b.rotation = bull.rotation
		#b.rotation.x += randf_range(-5,5)
		#b.rotation.y += randf_range(-0.3,0.3)
	return bull
