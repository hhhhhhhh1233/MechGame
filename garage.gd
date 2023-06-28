extends Control

var player_loadout

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

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		$WeaponMenu.get_popup().visible = false
		$BoosterMenu.get_popup().visible = false
		$LegMenu.get_popup().visible = false
	$ColorRect/Label.text = "$" + str(player_loadout.cash)

func _on_weapon_menu_id_pressed(id):
	if $WeaponMenu.get_popup().get_item_text(id)[0] == "[":
		if player_loadout.cash >= id*100:
			$WeaponMenu.get_popup().set_item_text(id, $WeaponMenu.get_popup().get_item_text(id).lstrip("[$" + str(id*100) + "] "))
			$WeaponMenu.get_popup().set_item_as_radio_checkable(id, true)
			player_loadout.cash -= id*100
		else:
			return

	for i in range($WeaponMenu.item_count):
		$WeaponMenu.get_popup().set_item_checked(i, false)
	$WeaponMenu.get_popup().set_item_checked(id, true)
	$WeaponMenu.text = $WeaponMenu.get_popup().get_item_text(id)
	player_loadout.weapon = player_loadout.weapons[id]
	
func _on_booster_menu_id_pressed(id):
	if $BoosterMenu.get_popup().get_item_text(id)[0] == "[":
		if player_loadout.cash >= id*100:
			$BoosterMenu.get_popup().set_item_text(id, $BoosterMenu.get_popup().get_item_text(id).lstrip("[$" + str(id*100) + "] "))
			$BoosterMenu.get_popup().set_item_as_radio_checkable(id, true)
			player_loadout.cash -= id*100
		else:
			return
		
	for i in range($BoosterMenu.item_count):
		$BoosterMenu.get_popup().set_item_checked(i, false)
	$BoosterMenu.get_popup().set_item_checked(id, true)
	$BoosterMenu.text = $BoosterMenu.get_popup().get_item_text(id)
	player_loadout.booster = player_loadout.boosters[id]

func _on_leg_menu_id_pressed(id):
	if $LegMenu.get_popup().get_item_text(id)[0] == "[":
		if player_loadout.cash >= id*100:
			$LegMenu.get_popup().set_item_text(id, $LegMenu.get_popup().get_item_text(id).lstrip("[$" + str(id*100) + "] "))
			$LegMenu.get_popup().set_item_as_radio_checkable(id, true)
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
