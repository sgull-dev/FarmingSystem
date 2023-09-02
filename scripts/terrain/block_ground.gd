extends Node3D

enum GROUND_MODE {DIRT, TILLED}

var ground_mode = GROUND_MODE.DIRT
var plant_type = PlantDatabase.PLANT_TYPE.NONE

var is_block = true

@onready var graphic = $Node3D/CSGBox3D


func till_block():
	print("Tilling block.")
	ground_mode = GROUND_MODE.TILLED
	graphic.material = load("res://materials/block_tilled.tres")


func add_plant(type):
	plant_type = type
	var plant = PlantDatabase.get_plant_node(type)
	add_child(plant)
	plant.position = Vector3.ZERO
