extends Node3D

var inventory

@onready var cast = $RayCast3D


func _ready():
	inventory = $"../../../PlayerInventory"


func _input(event):
	if event.is_action_pressed("use_item"):
		plant_seed()


func plant_seed():
	#Attempt to plant seeds.
	var plant_type
	match inventory.inventory[inventory.active_item_slot].item_name:
		"seeds_carrot":
			plant_type = PlantDatabase.PLANT_TYPE.CARROT
		"seeds_wheat":
			plant_type = PlantDatabase.PLANT_TYPE.WHEAT
		"seeds_corn":
			plant_type = PlantDatabase.PLANT_TYPE.CORN
		"seeds_tomato":
			plant_type = PlantDatabase.PLANT_TYPE.TOMATO
		_: 
			#if not holding seeds, return
			return
	
	#cast
	cast.force_raycast_update()
	var collider = cast.get_collider()
	if !collider == null:
		#if collider is block and plant type is none, plant the seeds
		if "is_block" in collider:
			if collider.plant_type == PlantDatabase.PLANT_TYPE.NONE:
				#check if ground is tilled
				if collider.ground_mode == collider.GROUND_MODE.TILLED:
					collider.add_plant(plant_type)
					inventory.remove_item(inventory.active_item_slot, 1)
