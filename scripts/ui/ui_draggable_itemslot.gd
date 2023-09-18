extends Panel

var player_inventory
var _dragpreview = preload("res://scenes/ui/dragpreview.tscn")


func _ready():
	player_inventory = GameData.get_current_stage().get_node("PlayerInventory")


func _get_drag_data(position: Vector2):
	print("Attempting to get drag_data.")
	var slot_from:int
	var str = name
	str = str.lstrip("ItemPanel")
	slot_from = int(str) - 1
	
	if player_inventory.inventory[slot_from].item_name == "null":
		print("Item is null, don't get drag.")
		return
	else:
		print("Got drag data.")
		var data = {"slot_from":slot_from}
		
		var dragpreview = _dragpreview.instantiate()
		dragpreview.texture = $TextureRect.texture
		add_child(dragpreview)
		
		return data


func _can_drop_data(position, data):
	return true


func _drop_data(at_position, data):
	var slot_to:int
	var str = name
	str = str.lstrip("ItemPanel")
	slot_to = int(str) - 1
	
	player_inventory.move_item(data.slot_from, slot_to)
