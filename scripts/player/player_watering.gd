extends Node3D


var item_active : bool = false
var can_water : bool = true

@onready var anim = $AnimationPlayer
@onready var cast = $RayCast3D
@onready var player_inventory = $"../../../PlayerInventory"


func _process(_delta):
	#if player is holding sickle in hand, activate
	if player_inventory.inventory[player_inventory.active_item_slot].item_name == "watering_can":
		item_active = true
		visible = true
	else:
		item_active = false
		visible = false
		anim.play("RESET")
		can_water = true


func _input(event):
	if event.is_action_pressed("use_item"):
		if can_water and item_active:
			water()


func water():
	#anim
	anim.play("Watering")
	#cast
	cast.force_raycast_update()
	var collider = cast.get_collider()
	#find collider
	if !collider == null:
		if "is_block" in collider:
			#If the collider is a block and the block's plant_type is correct, attempt to harvest plant
			if collider.ground_mode == collider.GROUND_MODE.TILLED:
				collider.water_level += 10
	await  anim.animation_finished
	can_water = true
