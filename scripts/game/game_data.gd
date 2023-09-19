extends Node

signal game_state_changed(state)

#vars for player
var player
var player_position : Vector3
var player_move_direction : Vector3
var cam_rotation : float

#vars for gamestate
enum GAME_STATE {PLAY, DIALOGUE, CUTSCENE, MENU}
var game_state = GAME_STATE.PLAY

var blueprints
var item_info


func _ready():
	player = get_current_stage().get_node("Player")
	blueprints = load_json_data("res://assets/data/blueprints.json")
	item_info = load_json_data("res://assets/data/item_info.json")


func load_json_data(path):
	var json_as_text = FileAccess.get_file_as_string(path)
	
	var json_as_dict = JSON.parse_string(json_as_text)
	if json_as_dict:
		return json_as_dict


func change_game_state(state):
	if state == GAME_STATE.PLAY:
		player.set_process_mode.call_deferred(PROCESS_MODE_ALWAYS)
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		player.set_process_mode.call_deferred(PROCESS_MODE_DISABLED)
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	game_state = state
	
	game_state_changed.emit(state)


func get_current_stage() -> Variant:
	var current_scene = null
	var i = 0
	while i < get_tree().get_root().get_child_count():
		if "is_stage" in get_tree().get_root().get_child(i):
			current_scene = get_tree().get_root().get_child(i)
			i += 100
		i += 1
	return current_scene
