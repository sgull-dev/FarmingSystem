extends HBoxContainer

var blueprint

var _mat_info = preload("res://scenes/ui/mat_info_cont.tscn")


func setup(b):
	#set name
	$ItemNameLabel.text = b.capitalize()
	#set icon
	var icon_p = "res://assets/ui/item_icons/" + b + ".png"
	$ItemIcon.texture = load(icon_p)
	#Set material requirement info
	for mat in GameData.blueprints[b].keys():
		var mat_info = _mat_info.instantiate()
		$ItemNameLabel2.add_sibling(mat_info)
		icon_p = "res://assets/ui/item_icons/" + mat + ".png"
		mat_info.get_node("MatIcon").texture = load(icon_p)
		mat_info.get_node("MatAmountLabel").text = str(GameData.blueprints[b][mat])
	#store blueprint index 
	blueprint = b


func craft_item():
	var player_inventory = GameData.get_current_stage().get_node("PlayerInventory")
	#Check if can craft item.
	var can_craft = true
	for mat in GameData.blueprints[blueprint].keys():
		if not player_inventory.has_item(mat, GameData.blueprints[blueprint][mat]):
			can_craft = false
	if can_craft:
		#Give item
		var item_to_add = GameData.item_info[blueprint].duplicate()
		player_inventory.get_item(item_to_add)
		#Remove materials.
		for mat in GameData.blueprints[blueprint].keys():
			player_inventory.remove_item_from_any_slot(mat, GameData.blueprints[blueprint][mat])
	

func _on_craft_button_button_down():
	craft_item()
