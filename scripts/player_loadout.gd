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
	var save = SaveGame.load_savegame()
	if save:
		weapons = save.weapons
		legs = save.legs
		boosters = save.boosters
		
		weapon = weapons[save.currentWeaponID]
		booster = boosters[save.currentBoosterID]
		leg = legs[save.currentLegID]
		
		cash = save.cash
	else:
		weapons = [Blaster.new(), RapidFire.new(), Shotgun.new()]
		legs = [Walker.new(), Skater.new(), Hovercraft.new()]
		boosters = [BuiltInBooster.new(), FastBooster.new(), ChargeBoost.new()]

		weapon = weapons[0]
		leg = legs[0]
		booster = boosters[0]

