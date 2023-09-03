extends Node3D

@export var ground_extents : Vector2i
@export var tree_spawn_change : float

var _block = preload("res://scenes/terrain/block_ground.tscn")

var noise = FastNoiseLite.new()
var noise_image


func _ready():
	gen_tree_noise()
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
			#spawn tree
			try_spawning_tree(block, x, y)


func gen_tree_noise():
	noise.seed = randi()
	noise.frequency = 0.16
	#gen image
	noise_image = noise.get_image(ground_extents.x, ground_extents.y)
	#debugging display
	var texture = ImageTexture.create_from_image(noise_image)
	$"../HUD/NoiseTexture".texture = texture


func try_spawning_tree(block, x, y):
	#print("Trying to spawn tree on block: (" + str(x) +"," + str(y) + ")")
	if noise_image.get_pixel(x,y).r < 0.24:
		block.add_plant(PlantDatabase.PLANT_TYPE.TREE)
