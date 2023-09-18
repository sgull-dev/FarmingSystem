extends Node3D

var can_interact := false

var craft_hud
var inv_hud


func _ready():
	craft_hud = GameData.get_current_stage().get_node("HUD/CraftingMenu")
	inv_hud = GameData.get_current_stage().get_node("HUD/BackpackHUD")


func _input(event):
	if can_interact and GameData.game_state == GameData.GAME_STATE.PLAY:
		if event.is_action_pressed("interact"):
			craft_hud.open_menu()
			inv_hud.open_menu()



func _on_interact_area_body_entered(body):
	if "is_player" in body:
		can_interact = true


func _on_interact_area_body_exited(body):
	if "is_player" in body:
		can_interact = false
