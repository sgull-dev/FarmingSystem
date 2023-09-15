extends Node3D

#terrain size
@export var ground_extents : Vector2i
@export var tree_spawn_change : float

var _block = preload("res://scenes/terrain/block_ground.tscn")

#vars for spawning trees
var noise = FastNoiseLite.new()
var noise_image


func _ready():
	gen_tree_noise()
	gen_ground(ground_extents)


func gen_ground(extents:Vector2i):
	print("Generating ground with extents: " + str(extents))
	
	#Starting position for placing blocks.
	var start_pos = Vector3(-extents.x, 0, -extents.y)
	
	#Iterate the x and y positions.
	for x in extents.x:
		for y in extents.y:
			#Multiply the x and y by 2 because ground_block is 2x2.
			var spawn_pos = start_pos + Vector3(2*x,0, 2*y)
			var block = _block.instantiate()
			add_child.call_deferred(block)
			block.position = spawn_pos
			#spawn tree
			try_spawning_tree(block, x, y)


func gen_tree_noise():
	#random noise
	noise.seed = randi()
	noise.frequency = 0.16
	#gen image from noise
	noise_image = noise.get_image(ground_extents.x, ground_extents.y)
	#debugging display
	var texture = ImageTexture.create_from_image(noise_image)
	$"../HUD/NoiseTexture".texture = texture


func try_spawning_tree(block, x, y):
	#print("Trying to spawn tree on block: (" + str(x) +"," + str(y) + ")")
	#if pixel at (x,y) is dark enough, spawn tree on (x,y) block
	if noise_image.get_pixel(x,y).r < 0.24:
		block.add_plant(PlantDatabase.PLANT_TYPE.TREE)
