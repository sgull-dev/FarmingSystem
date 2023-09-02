extends Node

enum PLANT_TYPE {NONE, TREE, CORN, WHEAT, CARROT}

var plants = [
	null,
	preload("res://scenes/plants/plant_tree.tscn"),
	null,
	null,
	null,
]


func get_plant_node(type):
	if plants[type] != null:
		var plant = plants[type].instantiate()
		return plant
	else:
		return null
