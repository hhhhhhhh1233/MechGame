extends Node

var cash = 200
var debt = 0

# UNUSED RIGHT NOW; USE THESE LATER
var repairCosts
var ammoCosts
var fuelCosts

var weapons
var legs
var boosters

var weapon
var booster
var leg

func _ready():
	weapons = [Blaster.new(), RapidFire.new(), Shotgun.new()]
	weapon = weapons[0]

	legs = [Walker.new(), Skater.new(), Hovercraft.new()]
	leg = legs[0]
	
	boosters = [BuiltInBooster.new(), FastBooster.new(), ChargeBoost.new()]
	booster = boosters[0]

