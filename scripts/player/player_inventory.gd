extends Node

const null_item = {"item_name": "null", "stackable": false, "amount": 0}

var inventory = [
	{"item_name": "hoe", "stackable": false, "amount": 1},
	{"item_name": "sickle", "stackable": false, "amount": 1},
	{"item_name": "null", "stackable": false, "amount": 0},
	{"item_name": "null", "stackable": false, "amount": 0},
	{"item_name": "null", "stackable": false, "amount": 0},
	{"item_name": "null", "stackable": false, "amount": 0},
	{"item_name": "null", "stackable": false, "amount": 0},
	{"item_name": "null", "stackable": false, "amount": 0},
]

var active_item_slot :int = 0

func _input(event):
	#handle changing active slot
	if event.is_action_pressed("item_slot_0"):
		active_item_slot = 0
	if event.is_action_pressed("item_slot_1"):
		active_item_slot = 1
	if event.is_action_pressed("item_slot_2"):
		active_item_slot = 2
	if event.is_action_pressed("item_slot_3"):
		active_item_slot = 3
	if event.is_action_pressed("item_slot_4"):
		active_item_slot = 4
	if event.is_action_pressed("item_slot_5"):
		active_item_slot = 5
	if event.is_action_pressed("item_slot_6"):
		active_item_slot = 6
	if event.is_action_pressed("item_slot_7"):
		active_item_slot = 7


func get_item(item:Dictionary):
	print("Giving item to player.")
	if item.stackable == false:
		print("Item is not stackable. Trying to put it to empty slot.")
		#check if there is space on inventory
		var slot = null
		var i = 0
		while i < inventory.size():
			if inventory[i].item_name == "null":
				slot = i
				break
			i += 1
		#input item into the slot
		if slot != null:
			print("Found empty slot for item, inserting.")
			inventory[slot] = item
	
	elif item.stackable == true:
		print("Item is stackable, trying to stack item.")
		#check if there is already specific item on inventory
		var slot = null
		var i = 0
		while i < inventory.size():
			if inventory[i].item_name == item.item_name:
				slot = i
				i += 1000
			i += 1
		#input item into the slot
		if slot != null:
			print("Found slot to stack item to. Stacking.")
			item.amount = inventory[slot].amount + item.amount
			inventory[slot] = item
			return
		#if we don't already have the stackable item, try placing it in empty slot
		else:
			print("Didn't find slot to stack item to. Trying to find empty slot.")
			i = 0
			while i < inventory.size():
				if inventory[i].item_name == "null":
					slot = i
					i += 1000
				i += 1
			#input item into the slot
			if slot != null:
				print("Found empty slot for item, inserting.")
				inventory[slot] = item
				return


func remove_item(slot, amount_to_remove):
	inventory[slot].amount -= amount_to_remove
	if inventory[slot].amount <= 0:
		inventory[slot] = null_item
