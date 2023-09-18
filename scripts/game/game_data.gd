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


func _ready():
	player = get_current_stage().get_node("Player")


func change_game_state(state):
	if state == GAME_STATE.PLAY:
		player.process_mode = PROCESS_MODE_ALWAYS
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		player.process_mode = PROCESS_MODE_DISABLED
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
