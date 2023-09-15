extends Node

#All the plant types in game. Use this to refer to plants anywhere in code.
enum PLANT_TYPE {NONE, TREE, CORN, WHEAT, CARROT}

var plants = [
	null,
	preload("res://scenes/plants/plant_tree.tscn"),
	preload("res://scenes/plants/plant_corn.tscn"),
	preload("res://scenes/plants/plant_wheat.tscn"),
	preload("res://scenes/plants/plant_carrot.tscn"),
]


#Instantiate plant.
func get_plant_node(type):
	if plants[type] != null:
		var plant = plants[type].instantiate()
		return plant
	else:
		print("ERROR: PlantDatabase spawner tried to spawn plant of unknown type. Returning null.")
		return null
