extends Control

var player_loadout: Object
@onready var menus = [$WeaponMenu, $BoosterMenu, $LegMenu]

func _ready():
	$WeaponMenu.grab_focus()
	player_loadout = get_node("/root/PlayerLoadout")
	
	$ColorRect/Label.text = "$%d" % player_loadout.cash
	
	var loadouts = [player_loadout.weapons, player_loadout.boosters, player_loadout.legs]
	var equipped = [player_loadout.weapon, player_loadout.booster, player_loadout.leg]
	
	var j = 0
	for menu in menus:
		menu.get_popup().hide_on_checkable_item_selection = false
		menu.get_popup().hide_on_item_selection = false
		menu.text = equipped[j].name
		for i in range(3):
			if not loadouts[j][i].owned:
				menu.get_popup().set_item_text(i, ("[$%d] " % (i*100)) + loadouts[j][i].name)
				menu.get_popup().set_item_as_radio_checkable(i, false)
			else:
				menu.get_popup().set_item_text(i, loadouts[j][i].name)
				menu.get_popup().set_item_as_radio_checkable(i, true)
		for i in range(menu.item_count):
			menu.get_popup().set_item_checked(i, false)
		menu.get_popup().set_item_checked(equipped[j].id, true)
		j += 1

	$WeaponMenu.get_popup().id_pressed.connect(_on_weapon_menu_id_pressed)
	$BoosterMenu.get_popup().id_pressed.connect(_on_booster_menu_id_pressed)
	$LegMenu.get_popup().id_pressed.connect(_on_leg_menu_id_pressed)


func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		for menu in menus:
			menu.get_popup().visible = false


func _on_weapon_menu_id_pressed(id):
	on_garage_item_selection(id, $WeaponMenu, player_loadout.weapons)
	player_loadout.weapon = player_loadout.weapons[id]


func _on_booster_menu_id_pressed(id):
	on_garage_item_selection(id, $BoosterMenu, player_loadout.boosters)
	player_loadout.booster = player_loadout.boosters[id]


func _on_leg_menu_id_pressed(id):
	on_garage_item_selection(id, $LegMenu, player_loadout.legs)
	player_loadout.leg = player_loadout.legs[id]


func on_garage_item_selection(id: int, menu: Object, category: Array):
	if not category[id].owned:
		if player_loadout.cash >= id*100:
			menu.get_popup().set_item_text(id, category[id].name)
			menu.get_popup().set_item_as_radio_checkable(id, true)
			category[id].owned = true
			player_loadout.cash -= id*100
			$ColorRect/Label.text = "$" + str(player_loadout.cash)
		else:
			return
			
	for i in range(menu.item_count):
		menu.get_popup().set_item_checked(i, false)
	menu.get_popup().set_item_checked(id, true)
	menu.text = menu.get_popup().get_item_text(id)

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
