extends Node3D

enum GROUND_MODE {DIRT, TILLED, GRASS}

var ground_mode = GROUND_MODE.DIRT
var plant_type = PlantDatabase.PLANT_TYPE.NONE

var is_block = true

@onready var graphic = $Node3D/ground_plane/Plane


func make_grass():
	ground_mode = GROUND_MODE.GRASS
	graphic.material_override = load("res://materials/block_grass.tres")
	graphic.material_overlay = null


func till_block():
	print("Tilling block.")
	ground_mode = GROUND_MODE.TILLED
	graphic.material_override = load("res://materials/block_tilled.tres")
	graphic.material_overlay = null
	add_till_overlay_to_neighboring_blocks()


func add_till_overlay_to_neighboring_blocks():
	var str = name
	var x = int(str.get_slice("_", 1))
	var y = int(str.get_slice("_", 2))
	print(x,y)
	#top neighbor
	var top_n_name = "Block_" + str(x-1) + "_" + str(y)
	var top_block = GameData.get_current_stage().get_node("GroundGenerator/" + top_n_name)
	if top_block != null:
		if top_block.ground_mode == GROUND_MODE.DIRT:
			top_block.get_node("Node3D/ground_plane/Plane").material_overlay = load("res://materials/block_overlay_till_top.tres")
	#bottom neighbor
	var bot_n_name = "Block_" + str(x+1) + "_" + str(y)
	var bot_block = GameData.get_current_stage().get_node("GroundGenerator/" + bot_n_name)
	if bot_block != null:
		if bot_block.ground_mode == GROUND_MODE.DIRT:
			bot_block.get_node("Node3D/ground_plane/Plane").material_overlay = load("res://materials/block_overlay_till_bottom.tres")


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
	graphic.material_overlay = null
