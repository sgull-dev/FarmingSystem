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
	await get_tree().process_frame
	update_neighboring_blocks_overlay()


func till_block():
	print("Tilling block.")
	ground_mode = GROUND_MODE.TILLED
	graphic.material_override = load("res://materials/block_tilled.tres")
	graphic.material_overlay = null
	update_neighboring_blocks_overlay()
	update_overlay_graphic()


func update_neighboring_blocks_overlay():
	var ground_gen = GameData.get_current_stage().get_node("GroundGenerator")
	var str = name
	var x = int(str.get_slice("_", 1))
	var y = int(str.get_slice("_", 2))
	
	if x >0:
		var left_name = "Block_" + str(x-1) + "_" + str(y)
		var left_block = GameData.get_current_stage().get_node("GroundGenerator/" + left_name)
		if left_block != null:
			left_block.update_overlay_graphic()
	
	if x < ground_gen.ground_extents.x-1:
		var right_name = "Block_" + str(x+1) + "_" + str(y)
		var r_block = GameData.get_current_stage().get_node("GroundGenerator/" + right_name)
		if r_block != null:
			r_block.update_overlay_graphic()
	
	if y < ground_gen.ground_extents.y-1:
		var t_name = "Block_" + str(x) + "_" + str(y+1)
		var t_block = GameData.get_current_stage().get_node("GroundGenerator/" + t_name)
		if t_block != null:
			t_block.update_overlay_graphic()
	
	if y>0:
		var b_name = "Block_" + str(x) + "_" + str(y-1)
		var b_block = GameData.get_current_stage().get_node("GroundGenerator/" + b_name)
		if b_block != null:
			b_block.update_overlay_graphic()


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
	update_neighboring_blocks_overlay()
	update_overlay_graphic()


func update_overlay_graphic():
	var ground_gen = GameData.get_current_stage().get_node("GroundGenerator")
	graphic.material_overlay = null
	var str = name
	var x = int(str.get_slice("_", 1))
	var y = int(str.get_slice("_", 2))
	
	if ground_mode == GROUND_MODE.GRASS:
		return
	elif ground_mode == GROUND_MODE.DIRT or ground_mode == GROUND_MODE.TILLED:
		#check neighboring blocks
		if x >0:
			var left_name = "Block_" + str(x-1) + "_" + str(y)
			var left_block = GameData.get_current_stage().get_node("GroundGenerator/" + left_name)
			if left_block != null:
				if left_block.ground_mode == GROUND_MODE.TILLED and ground_mode == GROUND_MODE.DIRT:
					graphic.material_overlay = load("res://materials/block_overlay_till_r.tres").duplicate()
				elif left_block.ground_mode == GROUND_MODE.GRASS:
					graphic.material_overlay = load("res://materials/block_overlay_grass_r.tres").duplicate()
				else:
					graphic.material_overlay = load("res://materials/block_overlay_none.tres").duplicate()
		else:
			graphic.material_overlay = load("res://materials/block_overlay_none.tres").duplicate()
#
		if x < ground_gen.ground_extents.x-1:
			var right_name = "Block_" + str(x+1) + "_" + str(y)
			var r_block = GameData.get_current_stage().get_node("GroundGenerator/" + right_name)
			if r_block != null:
				if r_block.ground_mode == GROUND_MODE.TILLED and ground_mode == GROUND_MODE.DIRT:
					graphic.material_overlay.next_pass = load("res://materials/block_overlay_till_l.tres").duplicate()
				elif r_block.ground_mode == GROUND_MODE.GRASS:
					graphic.material_overlay.next_pass = load("res://materials/block_overlay_grass_l.tres").duplicate()
				else:
					graphic.material_overlay.next_pass = load("res://materials/block_overlay_none.tres").duplicate()
		else:
			graphic.material_overlay.next_pass = load("res://materials/block_overlay_none.tres").duplicate()

		if y < ground_gen.ground_extents.y-1:
			var t_name = "Block_" + str(x) + "_" + str(y+1)
			var t_block = GameData.get_current_stage().get_node("GroundGenerator/" + t_name)
			if t_block != null:
				if t_block.ground_mode == GROUND_MODE.GRASS:
					graphic.material_overlay.next_pass.next_pass = load("res://materials/block_overlay_grass_t.tres").duplicate()
				else:
					graphic.material_overlay.next_pass.next_pass = load("res://materials/block_overlay_none.tres").duplicate()
		else:
			graphic.material_overlay.next_pass.next_pass = load("res://materials/block_overlay_none.tres").duplicate()
		
		if y > 0:
			var b_name = "Block_" + str(x) + "_" + str(y-1)
			var b_block = GameData.get_current_stage().get_node("GroundGenerator/" + b_name)
			if b_block != null:
				if b_block.ground_mode == GROUND_MODE.GRASS:
					graphic.material_overlay.next_pass.next_pass.next_pass = load("res://materials/block_overlay_grass_b.tres").duplicate()
				else:
					graphic.material_overlay.next_pass.next_pass.next_pass = load("res://materials/block_overlay_none.tres").duplicate()
		else:
			graphic.material_overlay.next_pass.next_pass.next_pass = load("res://materials/block_overlay_none.tres").duplicate()


#func set_overlay(mat):
#	if graphic.material_overlay == null:
#		graphic.material_overlay = mat
#	else:
#		if graphic.material_overlay.get_next_pass() == null:
#			graphic.material_overlay.set_next_pass(mat)
#		else:
#			if graphic.material_overlay.next_pass.get_next_pass() == null:
#				graphic.material_overlay.next_pass.set_next_pass(mat)
#			else:
#				if graphic.material_overlay.next_pass.next_pass.get_next_pass() == null:
#					graphic.material_overlay.next_pass.next_pass.set_next_pass(mat)
		
