extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$WeaponMenu.grab_focus()
	
	$WeaponMenu.get_popup().hide_on_checkable_item_selection = false
	$BoosterMenu.get_popup().hide_on_checkable_item_selection = false
	$LegMenu.get_popup().hide_on_checkable_item_selection = false
	
	$WeaponMenu.get_popup().id_pressed.connect(_on_weapon_menu_id_pressed)
	$BoosterMenu.get_popup().id_pressed.connect(_on_booster_menu_id_pressed)
	$LegMenu.get_popup().id_pressed.connect(_on_leg_menu_id_pressed)
	
	$WeaponMenu.text = $WeaponMenu.get_popup().get_item_text(0)
	$BoosterMenu.text = $BoosterMenu.get_popup().get_item_text(0)
	$LegMenu.text = $LegMenu.get_popup().get_item_text(0)

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		$WeaponMenu.get_popup().visible = false
		$BoosterMenu.get_popup().visible = false
		$LegMenu.get_popup().visible = false

func _on_weapon_menu_id_pressed(id):
	for i in range($WeaponMenu.item_count):
		$WeaponMenu.get_popup().set_item_checked(i, false)
	$WeaponMenu.get_popup().set_item_checked(id, true)
	$WeaponMenu.text = $WeaponMenu.get_popup().get_item_text(id)
	
func _on_booster_menu_id_pressed(id):
	for i in range($BoosterMenu.item_count):
		$BoosterMenu.get_popup().set_item_checked(i, false)
	$BoosterMenu.get_popup().set_item_checked(id, true)
	$BoosterMenu.text = $BoosterMenu.get_popup().get_item_text(id)

func _on_leg_menu_id_pressed(id):
	for i in range($LegMenu.item_count):
		$LegMenu.get_popup().set_item_checked(i, false)
	$LegMenu.get_popup().set_item_checked(id, true)
	$LegMenu.text = $LegMenu.get_popup().get_item_text(id)


func _on_button_pressed():
	get_tree().change_scene_to_file("res://test_world.tscn")
