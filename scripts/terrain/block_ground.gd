extends Node3D

enum GROUND_MODE {DIRT, TILLED}

var ground_mode = GROUND_MODE.DIRT


func till_block():
	ground_mode = GROUND_MODE.TILLED
