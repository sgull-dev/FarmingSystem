extends Node

const null_item = {"item_name": "null", "stackable": false, "amount": 0}
const max_stack_amount = 99

var inventory

var active_item_slot :int = 0


func _ready():
	#setup inventory
	inventory = []
	inventory.resize(8+3*8)
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
	print("Giving item to player.")
	#If item isn't stackable, put it in empty slot.
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
	
	#If item is stackable, first try stacking it with an already existing stack.
	elif item.stackable == true:
		print("Item is stackable, trying to stack item.")
		#check is there stack of item
		var slot = null
		var i = 0
		while i < inventory.size():
			if inventory[i].item_name == item.item_name:
				if inventory[i].amount < max_stack_amount:
					slot = i
					i += 1000
			i += 1
		#input item into the stack
		if slot != null:
			print("Found slot to stack item to. Stacking.")
			var amount_check = inventory[slot].amount + item.amount
			#if stack has more than max, split into two
			if amount_check > max_stack_amount:
				#change old stack value
				inventory[slot].amount = max_stack_amount
				item.amount = amount_check - max_stack_amount
				#insert new stack
				var _i = 0
				var inserted = false
				while _i < inventory.size():
					if inventory[_i].item_name == "null":
						inventory[_i] = item
						inserted = true
						_i += 1000
					_i += 1
				if !inserted:
					#TO-DO: Dropping items
					print("No space in inventory, Dropping item to ground.")
					pass
				
			item.amount = inventory[slot].amount + item.amount
			inventory[slot] = item
			return
		#if no stack ready, put to empty slot
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


func move_item(slot_from, slot_to):
	var item_to_move_1 = inventory[slot_from].duplicate()
	var item_to_move_2 = inventory[slot_to].duplicate()
	
	inventory[slot_from] = item_to_move_2
	inventory[slot_to] = item_to_move_1
