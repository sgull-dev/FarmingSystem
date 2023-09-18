extends Control

var is_menu_open := false
var player_inventory


func _ready():
	visible = false
	player_inventory = GameData.get_current_stage().get_node("PlayerInventory")


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
