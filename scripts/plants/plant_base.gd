extends Node3D

@export var growth_chance: float = 0.1
@export var item_to_give = {"item_name":"item_name", "stackable": true, "amount": 3}

#track growth from 0-10
var growth: int
var harvestable: bool = false

var is_crop = true

@onready var graphic_sapling = $Models/Sapling
@onready var graphic_middle = $Models/Middle
@onready var graphic_ready = $Models/Ready


func _ready():
	GameData.get_current_stage().get_node("TimeManager").tick.connect(on_tick)


func grow_plant():
	growth += 1
	if growth == 10:
		harvestable = true
	update_plant_graphic()


func harvest_plant():
	print("Harvesting plant.")
	#if plant is harvestable, we harvest
	if harvestable:
		#get inventory reference
		var inventory = GameData.get_current_stage().get_node("PlayerInventory")
		#insert item to inventory
		var item = item_to_give.duplicate()
		inventory.get_item(item)
		print("Givin Player item:" + str(item_to_give))
		#reset parent block
		var block = $".."
		block.reset_block()
		#remove plant
		queue_free()


func update_plant_graphic():
	if growth <= 3:
		graphic_sapling.visible = true
	elif growth <= 9:
		graphic_sapling.visible = false
		graphic_middle.visible = true
	elif harvestable:
		graphic_sapling.visible = false
		graphic_middle.visible = false
		graphic_ready.visible = true


func on_tick():
	if !harvestable:
		if randf_range(0.0, 1.0) < growth_chance:
			grow_plant()