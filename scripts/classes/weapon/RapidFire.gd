extends Weapon
class_name RapidFire

func _init():
	id = 1
	name = "Rapid Fire"
	owned = false
	bullet = preload("res://scenes/strong_bullet.tscn")
	shoot_delay = 0.1
	weight = 0.1
	autoRange = 30

func shoot(gun, enemiesInSight, closestEnemy):
	var bull = bullet.instantiate()
	gun.add_child(bull)
	if enemiesInSight:
		bull.changeDirection(Vector3(closestEnemy.global_position - gun.global_position).normalized())
	return bull
