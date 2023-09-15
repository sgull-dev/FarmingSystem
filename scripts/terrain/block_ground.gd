extends Node3D

enum GROUND_MODE {DIRT, TILLED}

var ground_mode = GROUND_MODE.DIRT
var plant_type = PlantDatabase.PLANT_TYPE.NONE

var is_block = true

@onready var graphic = $Node3D/ground_plane/Plane


func till_block():
	print("Tilling block.")
	ground_mode = GROUND_MODE.TILLED
	graphic.material_override = load("res://materials/block_tilled.tres")


func add_plant(type):
	#change plant type to PlantDatabase enum
	plant_type = type
	#instantiate plant as child
	var plant = PlantDatabase.get_plant_node(type)
	add_child(plant)
	plant.position = Vector3.ZERO


func reset_block():
	#reset block back to original
	ground_mode = GROUND_MODE.DIRT
	plant_type = PlantDatabase.PLANT_TYPE.NONE
	graphic.material_override = load("res://materials/block_ground.tres")
