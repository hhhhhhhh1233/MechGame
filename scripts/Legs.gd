class_name Legs

var id: int
var name: String
var owned: bool
var speed: float
var weight: float
var jump_velocity: float

func _init(i: int, n: String, o: bool, s: float, w: float, jv: float):
	id = i
	name = n
	owned = o
	speed = s
	weight = w
	jump_velocity = jv
