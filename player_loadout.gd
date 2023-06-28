extends Node

@onready var BLASTER_BULLET = preload("res://bullet.tscn")
@onready var RAPID_BULLET = preload("res://strong_bullet.tscn")

var cash = 500

var Blaster
var Rapid_fire
var weapons

var Walker
var Skater
var legs

var Default_booster
var Fast_booster
var boosters

var weapon
var booster
var leg

func _ready():
	Blaster = Weapon.new(BLASTER_BULLET, 0.3, 0.05)
	Rapid_fire = Weapon.new(RAPID_BULLET, 0.1, 0.1)
	weapons = [Blaster, Rapid_fire]
	weapon = weapons[0]

	Walker = Legs.new(7.5, 0.2, 8)
	Skater = Legs.new(10, 0.3, 10)
	legs = [Walker, Skater]
	leg = legs[0]
	
	Default_booster = Booster.new(7, 0.1, 0.1)
	Fast_booster = Booster.new(10, 0.2, 0.15)
	boosters = [Default_booster, Fast_booster]
	booster = boosters[0]
