extends Node3D

var item_active : bool = false
var can_swing_hoe : bool = true

@onready var anim = $AnimationPlayer
@onready var cast = $RayCast3D
@onready var player_inventory = $"../../../PlayerInventory"


func _process(_delta):
	#if player is holding sickle in hand, activate
	if player_inventory.inventory[player_inventory.active_item_slot].item_name == "sickle":
		item_active = true
		visible = true
	else:
		item_active = false
		visible = false
		anim.play("RESET")
		can_swing_hoe = true


func _input(event):
	if event.is_action_pressed("use_item"):
		if can_swing_hoe and item_active:
			swing_hoe()


func swing_hoe():
	#anim
	anim.play("SwingSickle")
	#cast
	cast.force_raycast_update()
	var collider = cast.get_collider()
	#find collider
	if !collider == null:
		if "is_block" in collider:
			#If the collider is a block and the block's plant_type is correct, attempt to harvest plant
			if collider.plant_type != PlantDatabase.PLANT_TYPE.TREE or collider.plant_type != PlantDatabase.PLANT_TYPE.NONE:
				for child in collider.get_children():
					if "is_crop" in child:
						child.harvest_plant()
						break
	await  anim.animation_finished
	can_swing_hoe = true
