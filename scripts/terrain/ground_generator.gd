extends Node3D

@export var ground_extents : Vector2i
@export var tree_spawn_change : float

var _block = preload("res://scenes/terrain/block_ground.tscn")


func _ready():
	gen_ground(ground_extents)


func gen_ground(extents:Vector2i):
	print("Generating ground with extents: " + str(extents))
	var start_pos = Vector3(-extents.x/2, 0, -extents.y/2)
	
	for x in extents.x:
		for y in extents.y:
			var spawn_pos = start_pos + Vector3(2*x,0, 2*y)
			var block = _block.instantiate()
			add_child.call_deferred(block)
			block.position = spawn_pos
			#spawn tree on rand_change
			if tree_spawn_change > randf_range(0.0, 100.0):
				block.add_plant(PlantDatabase.PLANT_TYPE.TREE)
