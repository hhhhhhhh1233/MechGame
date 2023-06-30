extends Weapon
class_name Blaster

func _init():
	id = 0
	name = "Blaster"
	owned = true
	bullet = preload("res://scenes/bullet.tscn")
	shoot_delay = 0.3
	weight = 0.05
	autoRange = 30

func shoot(gun, enemiesInSight, closestEnemy):
	var bull = bullet.instantiate()
	gun.add_child(bull)
	if enemiesInSight:
		bull.changeDirection(Vector3(closestEnemy.global_position - gun.global_position).normalized())
	return bull
