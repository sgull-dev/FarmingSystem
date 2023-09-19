extends Node3D

@export var item_name: String
var amount:= 1

var can_interact := false


func _input(event):
	if can_interact:
		if event.is_action_pressed("interact"):
			pick_up()


func pick_up():
	var inv = GameData.get_current_stage().get_node("PlayerInventory")
	var item_to_get = GameData.item_info[item_name].duplicate()
	item_to_get.amount = amount
	
	inv.get_item(item_to_get)
	
	queue_free()


func _on_interact_area_body_entered(body):
	if "is_player" in body:
		can_interact = true


func _on_interact_area_body_exited(body):
	if "is_player" in body:
		can_interact = false
