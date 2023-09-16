extends Node3D

#terrain size
@export var ground_extents : Vector2i
@export var tree_chance : float
@export var grass_chance : float

var _block = preload("res://scenes/terrain/block_ground.tscn")

#vars for spawning trees
var noise = FastNoiseLite.new()

var tree_noise_image
var grass_noise_image


func _ready():
	tree_noise_image = gen_noise_image(0.16)
	grass_noise_image = gen_noise_image(0.05)
	gen_ground(ground_extents)
	#debug show noise texture
	var texture = ImageTexture.create_from_image(grass_noise_image)
	$"../HUD/NoiseTexture".texture = texture


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
			#name block
			var name_str = "Block_" + str(x) + "_" + str(y)
			block.name = name_str
			add_child(block)
			block.position = spawn_pos
			#spawn tree
			try_spawning_tree(block, x, y)
			try_spawning_grass(block, x, y)


func gen_noise_image(freq)->Image:
	#random noise
	noise.seed = randi()
	noise.frequency = freq
	#gen image from noise
	var img = noise.get_image(ground_extents.x, ground_extents.y)
	return img


func try_spawning_tree(block, x, y):
	#print("Trying to spawn tree on block: (" + str(x) +"," + str(y) + ")")
	#if pixel at (x,y) is dark enough, spawn tree on (x,y) block
	if tree_noise_image.get_pixel(x,y).r < tree_chance:
		block.add_plant(PlantDatabase.PLANT_TYPE.TREE)


func try_spawning_grass(block, x, y):
	if grass_noise_image.get_pixel(x,y).r < grass_chance:
		block.make_grass()
