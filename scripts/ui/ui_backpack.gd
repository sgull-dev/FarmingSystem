extends Control

var is_menu_open := false
var player_inventory


func _ready():
	visible = false
	player_inventory = GameData.get_current_stage().get_node("PlayerInventory")


func _process(delta):
	if is_menu_open:
		update_inventory()


func _input(event):
	if event.is_action_pressed("inventory_menu"):
		if is_menu_open:
			close_menu()
		elif !is_menu_open:
			open_menu()


func open_menu():
	is_menu_open = true
	visible = true
	GameData.change_game_state(GameData.GAME_STATE.MENU)


func close_menu():
	is_menu_open = false
	visible = false
	GameData.change_game_state(GameData.GAME_STATE.PLAY)


func update_inventory():
	var i = 0
	for inv_slot in $GridContainer.get_children():
		#set icons
		if player_inventory.inventory[i].item_name == "null":
			inv_slot.get_node("TextureRect").texture = null
		else:
			var texture_path = "res://assets/ui/item_icons/" + player_inventory.inventory[i].item_name + ".png"
			inv_slot.get_node("TextureRect").texture = load(texture_path)
		
		inv_slot.get_node("Selected").visible = false
		#set amount text
		if player_inventory.inventory[i].stackable == false:
			inv_slot.get_node("AmountText").visible = false
		else:
			inv_slot.get_node("AmountText").visible = true
			inv_slot.get_node("AmountText").text = "x" + str(player_inventory.inventory[i].amount)
		i += 1
