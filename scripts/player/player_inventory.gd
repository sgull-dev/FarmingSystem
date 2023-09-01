extends Node

var inventory = [
	{"item_name": "hoe"},
	{"item_name": "null"},
	{"item_name": "null"},
	{"item_name": "null"},
	{"item_name": "null"},
	{"item_name": "null"},
	{"item_name": "null"},
	{"item_name": "null"},
]

var active_item_slot :int = 0

func _input(event):
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
		
