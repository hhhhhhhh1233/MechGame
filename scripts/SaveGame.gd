extends Resource
class_name SaveGame

const SAVE_GAME_PATH := "user://savegame.tres"

@export var weapons: Array
@export var legs: Array
@export var boosters: Array

@export var currentWeaponID: int
@export var currentBoosterID: int
@export var currentLegID: int

@export var cash: int

func write_savegame(w, l, b, cwi, cbi, cli, c) -> void:
	weapons = w
	legs = l
	boosters = b
	currentWeaponID = cwi
	currentBoosterID = cbi
	currentLegID = cli
	cash = c
	
	ResourceSaver.save(self, SAVE_GAME_PATH)

static func load_savegame() -> Resource:
	if ResourceLoader.exists(SAVE_GAME_PATH):
		return load(SAVE_GAME_PATH)
	return null
