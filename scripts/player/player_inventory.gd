extends Node

const null_item = {"item_name": "null", "stackable": false, "amount": 0}
const max_stack_amount = 99

var inventory

var active_item_slot :int = 0


func _ready():
	#setup inventory
	inventory = []
	inventory.resize(32)
	inventory.fill(null_item)
	inventory[0] = {"item_name": "hoe", "stackable": false, "amount": 1}
	inventory[1] = {"item_name": "sickle", "stackable": false, "amount": 1}


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
	#If item isn't stackable, put it in empty slot.
	if item.stackable == false:
		print("Item is not stackable. Trying to put it to empty slot.")
		#check if there is space on inventory
		var i = 0
		while i < inventory.size():
			if inventory[i].item_name == "null":
				inventory[i] = item
				break
			i += 1
	
	#If item is stackable, first try stacking it with an already existing stack.
	elif item.stackable == true:
		print("Inputting stackable item to invenotyr.")
		var amount_to_stack = item.amount
		#first stack
		for slot in inventory:
			if slot.item_name == item.item_name:
				print("Found slot to stack item to.")
				if slot.amount < max_stack_amount:
					#Stack item to slot
					var stack_amount = clamp(max_stack_amount - slot.amount, 0, amount_to_stack)
					print("Stacking "+str(stack_amount)+ " of "+str(item.item_name)+ " to slot.")
					amount_to_stack -= stack_amount
					slot.amount += stack_amount
					if amount_to_stack <= 0:
						break
		#then if still items, put to empty
		if amount_to_stack > 0:
			var i = 0 
			while i < inventory.size():
				if inventory[i].item_name == "null":
					print("Putting item to empty slot.")
					var new_item = item.duplicate()
					new_item.amount = amount_to_stack
					
					inventory[i] = new_item
					break
				i += 1



func remove_item(slot, amount_to_remove):
	inventory[slot].amount -= amount_to_remove
	if inventory[slot].amount <= 0:
		inventory[slot] = null_item


func move_item(slot_from, slot_to):
	var item_to_move_1 = inventory[slot_from].duplicate()
	var item_to_move_2 = inventory[slot_to].duplicate()
	
	inventory[slot_from] = item_to_move_2
	inventory[slot_to] = item_to_move_1
