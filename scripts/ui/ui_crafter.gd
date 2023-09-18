extends Control

var is_menu_open := false
var player_inventory

var _craft_cont = preload("res://scenes/ui/craft_cont.tscn")


func _ready():
	visible = false
	player_inventory = GameData.get_current_stage().get_node("PlayerInventory")
	setup_menu()


func _input(event):
	if event.is_action_pressed("inventory_menu"):
		if is_menu_open:
			close_menu()
		elif !is_menu_open:
			open_menu()


func setup_menu():
	for blueprint in GameData.blueprints.keys():
		var craft_cont = _craft_cont.instantiate()
		$VBoxContainer/VBoxContainer.add_child(craft_cont)
		craft_cont.setup(blueprint)


func open_menu():
	is_menu_open = true
	visible = true
	GameData.change_game_state(GameData.GAME_STATE.MENU)


func close_menu():
	is_menu_open = false
	visible = false
	GameData.change_game_state(GameData.GAME_STATE.PLAY)
