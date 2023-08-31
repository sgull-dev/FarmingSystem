extends Node3D

enum GROUND_MODE {DIRT, TILLED}

var ground_mode = GROUND_MODE.DIRT
var is_block = true

@onready var graphic = $CSGBox3D


func till_block():
	print("Tilling block.")
	ground_mode = GROUND_MODE.TILLED
	graphic.material = load("res://materials/block_tilled.tres")
