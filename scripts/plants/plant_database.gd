extends Node

enum PLANT_TYPE {NONE, TREE, CORN, WHEAT, CARROT}

var plants = [
	null,
	preload("res://scenes/plants/plant_tree.tscn"),
	preload("res://scenes/plants/plant_corn.tscn"),
	preload("res://scenes/plants/plant_wheat.tscn"),
	preload("res://scenes/plants/plant_carrot.tscn"),
]


func get_plant_node(type):
	if plants[type] != null:
		var plant = plants[type].instantiate()
		return plant
	else:
		return null
