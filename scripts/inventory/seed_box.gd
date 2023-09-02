extends Node3D

@export var seed_type_to_give: String
@export var seed_amount_to_give: int

var inventory
var can_interact := false


func _ready():
	inventory = GameData.get_current_stage().get_node("PlayerInventory")


func _input(event):
	if can_interact:
		if event.is_action_pressed("interact"):
			give_seeds()


func give_seeds():
	var seed_dict = {"item_name":seed_type_to_give, "stackable": true, "amount": seed_amount_to_give}
	#give player some seeds
	inventory.get_item(seed_dict)


func _on_interact_area_body_entered(body):
	if "is_player" in body:
		can_interact = true


func _on_interact_area_body_exited(body):
	if "is_player" in body:
		can_interact = false
