extends Node3D

enum GROUND_MODE {DIRT, TILLED}

var ground_mode = GROUND_MODE.DIRT

@onready var graphic = $CSGBox3D


func till_block():
	ground_mode = GROUND_MODE.TILLED
	graphic.material.albedo_texture = load("res://assets/ground/ground_tilled.png")
