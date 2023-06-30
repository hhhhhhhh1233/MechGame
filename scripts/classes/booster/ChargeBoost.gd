extends Booster
class_name ChargeBoost

var charge : float
var chargeLimit : float

func _init():
	id = 2
	name = "Charge Boost"
	owned = false
	weight = 0.2
	charge = 0
	chargeLimit = 30

func boost(_player, _walkingRay):
	charge += 0.5
	if charge > chargeLimit:
		charge = chargeLimit
	print(charge)
	
func releaseBoost(player, _walkingRay):
	player.velocity.y += charge
	charge = 0
