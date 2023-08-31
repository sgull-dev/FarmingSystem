extends Node3D

@export var ground_extents : Vector2i

var _block = preload("res://scenes/terrain/block_ground.tscn")


func _ready():
	gen_ground(ground_extents)


func gen_ground(extents:Vector2i):
	print("Generating ground with extents: " + str(extents))
	var start_pos = Vector3(-extents.x/2, 0, -extents.y/2)
	
	for x in extents.x:
		for y in extents.y:
			var spawn = start_pos + Vector3(x,0, y)
			var block = _block.instantiate()
			add_child.call_deferred(block)
			block.position = spawn
			#start_pos.z += 1
		#start_pos.x += 1
