extends Node3D

var item_active : bool = false
var can_swing_hoe : bool = true

@onready var anim = $AnimationPlayer
@onready var cast = $RayCast3D
@onready var player_inventory = $"../../../PlayerInventory"


func _process(_delta):
	if player_inventory.inventory[player_inventory.active_item_slot].item_name == "hoe":
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
	#print("Swinging hoe.")
	can_swing_hoe = false
	#anim
	anim.play("SwingHoe")
	#cast
	cast.force_raycast_update()
	var collider = cast.get_collider()
	if !collider == null:
		#print("Raycast found something.")
		#print(collider)
		if "is_block" in collider:
			#print("Body was block.")
			if collider.plant_type != PlantDatabase.PLANT_TYPE.TREE:
				collider.till_block()
	await  anim.animation_finished
	can_swing_hoe = true
