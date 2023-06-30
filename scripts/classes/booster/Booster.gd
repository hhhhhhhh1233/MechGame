class_name Booster

var id: int
var name: String
var owned: bool
var boost_velocity: float
var boost_acceleration: float
var weight: float

func _init(i: int, n: String, o: bool, bv: float, ba: float, w: float):
	id = i
	name = n
	owned = o
	boost_velocity = bv
	boost_acceleration = ba
	weight = w

func boost(player, walkingRay):
	walkingRay.enabled = false
	player.velocity.y += boost_velocity * boost_acceleration - weight
	if player.velocity.y > boost_velocity:
		player.velocity.y = boost_velocity

func releaseBoost(_player, walkingRay):
	walkingRay.enabled = true
