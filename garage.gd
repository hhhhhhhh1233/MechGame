extends Control

var player_loadout: Object

# Called when the node enters the scene tree for the first time.
func _ready():
	$WeaponMenu.grab_focus()
	
	$WeaponMenu.get_popup().hide_on_checkable_item_selection = false
	$WeaponMenu.get_popup().hide_on_item_selection = false
	$BoosterMenu.get_popup().hide_on_checkable_item_selection = false
	$BoosterMenu.get_popup().hide_on_item_selection = false
	$LegMenu.get_popup().hide_on_checkable_item_selection = false
	$LegMenu.get_popup().hide_on_item_selection = false
	
	$WeaponMenu.get_popup().id_pressed.connect(_on_weapon_menu_id_pressed)
	$BoosterMenu.get_popup().id_pressed.connect(_on_booster_menu_id_pressed)
	$LegMenu.get_popup().id_pressed.connect(_on_leg_menu_id_pressed)
	
	$WeaponMenu.text = $WeaponMenu.get_popup().get_item_text(0)
	$BoosterMenu.text = $BoosterMenu.get_popup().get_item_text(0)
	$LegMenu.text = $LegMenu.get_popup().get_item_text(0)
	
	player_loadout = get_node("/root/PlayerLoadout")
	
	for i in range(2):
		if not player_loadout.weapons[i].owned:
			$WeaponMenu.get_popup().set_item_text(i, ("[$%d] " % (i*100)) + player_loadout.weapons[i].name)
			$WeaponMenu.get_popup().set_item_as_radio_checkable(i, false)
		else:
			$WeaponMenu.get_popup().set_item_text(i, player_loadout.weapons[i].name)
			$WeaponMenu.get_popup().set_item_as_radio_checkable(i, true)
			
		if not player_loadout.boosters[i].owned:
			$BoosterMenu.get_popup().set_item_text(i, ("[$%d] " % (i*100)) + player_loadout.boosters[i].name)
			$BoosterMenu.get_popup().set_item_as_radio_checkable(i, false)
		else:
			$BoosterMenu.get_popup().set_item_text(i, player_loadout.boosters[i].name)
			$BoosterMenu.get_popup().set_item_as_radio_checkable(i, true)
		
		if not player_loadout.legs[i].owned:
			$LegMenu.get_popup().set_item_text(i, ("[$%d] " % (i*100)) + player_loadout.legs[i].name)
			$LegMenu.get_popup().set_item_as_radio_checkable(i, false)
		else:
			$LegMenu.get_popup().set_item_text(i, player_loadout.legs[i].name)
			$LegMenu.get_popup().set_item_as_radio_checkable(i, true)
		
	$WeaponMenu.text = player_loadout.weapon.name
	$BoosterMenu.text = player_loadout.booster.name
	$LegMenu.text = player_loadout.leg.name
	
	for i in range($WeaponMenu.item_count):
		$WeaponMenu.get_popup().set_item_checked(i, false)
		$BoosterMenu.get_popup().set_item_checked(i, false)
		$LegMenu.get_popup().set_item_checked(i, false)
	$WeaponMenu.get_popup().set_item_checked(player_loadout.weapon.id, true)
	$BoosterMenu.get_popup().set_item_checked(player_loadout.booster.id, true)
	$LegMenu.get_popup().set_item_checked(player_loadout.leg.id, true)

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		$WeaponMenu.get_popup().visible = false
		$BoosterMenu.get_popup().visible = false
		$LegMenu.get_popup().visible = false
	$ColorRect/Label.text = "$" + str(player_loadout.cash)

func _on_weapon_menu_id_pressed(id):
	if not player_loadout.weapons[id].owned:
		if player_loadout.cash >= id*100:
			$WeaponMenu.get_popup().set_item_text(id, player_loadout.weapons[id].name)
			$WeaponMenu.get_popup().set_item_as_radio_checkable(id, true)
			player_loadout.weapons[id].owned = true
			player_loadout.cash -= id*100
		else:
			return

	for i in range($WeaponMenu.item_count):
		$WeaponMenu.get_popup().set_item_checked(i, false)
	$WeaponMenu.get_popup().set_item_checked(id, true)
	$WeaponMenu.text = $WeaponMenu.get_popup().get_item_text(id)
	player_loadout.weapon = player_loadout.weapons[id]
	
func _on_booster_menu_id_pressed(id):
	if not player_loadout.boosters[id].owned:
		if player_loadout.cash >= id*100:
			$BoosterMenu.get_popup().set_item_text(id, player_loadout.boosters[id].name)
			$BoosterMenu.get_popup().set_item_as_radio_checkable(id, true)
			player_loadout.boosters[id].owned = true
			player_loadout.cash -= id*100
		else:
			return
		
	for i in range($BoosterMenu.item_count):
		$BoosterMenu.get_popup().set_item_checked(i, false)
	$BoosterMenu.get_popup().set_item_checked(id, true)
	$BoosterMenu.text = $BoosterMenu.get_popup().get_item_text(id)
	player_loadout.booster = player_loadout.boosters[id]

func _on_leg_menu_id_pressed(id):
	if not player_loadout.legs[id].owned:
		if player_loadout.cash >= id*100:
			$LegMenu.get_popup().set_item_text(id, player_loadout.legs[id].name)
			$LegMenu.get_popup().set_item_as_radio_checkable(id, true)
			player_loadout.legs[id].owned = true
			player_loadout.cash -= id*100
		else:
			return
		
	for i in range($LegMenu.item_count):
		$LegMenu.get_popup().set_item_checked(i, false)
	$LegMenu.get_popup().set_item_checked(id, true)
	$LegMenu.text = $LegMenu.get_popup().get_item_text(id)
	player_loadout.leg = player_loadout.legs[id]


func _on_button_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")
