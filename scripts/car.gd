extends Node3D

var health = 150
var explosiveDamage = 100

func decreaseHealth(amount):
	health -= amount
	if health <= 0:
		var bodiesInRange = $ExplosiveRange.get_overlapping_bodies()
		for body in bodiesInRange:
			body.decreaseHealth(explosiveDamage)
		queue_free()
