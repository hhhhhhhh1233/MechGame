class_name Weapon

var id: int
var name: String
var owned: bool
var bullet: Object
var shoot_delay: float
var weight: float
var autoRange: float


func _init(i: int, n: String, o: bool, b: Object, sd: float, w: float):
	id = i
	name = n
	owned = o
	bullet = b
	shoot_delay = sd
	weight = w

func shoot(gun, enemiesInSight, closestEnemy):
	print(gun, enemiesInSight, closestEnemy)
