extends Control

@onready var player_inventory = $"../../PlayerInventory"


func _process(_delta):
	update_inventory()


func update_inventory():
	var i = 0
	for inv_slot in $HBoxContainer.get_children():
		#set icons
		if player_inventory.inventory[i].item_name == "null":
			inv_slot.get_node("TextureRect").texture = null
		else:
			var texture_path = "res://assets/ui/item_icons/" + player_inventory.inventory[i].item_name + ".png"
			inv_slot.get_node("TextureRect").texture = load(texture_path)
		#set selected slot
		if player_inventory.active_item_slot == i:
			inv_slot.get_node("Selected").visible = true
		else:
			inv_slot.get_node("Selected").visible = false
		#set amount text
		if player_inventory.inventory[i].stackable == false:
			inv_slot.get_node("AmountText").visible = false
		else:
			inv_slot.get_node("AmountText").visible = true
			inv_slot.get_node("AmountText").text = "x" + str(player_inventory.inventory[i].amount)
		i += 1
