extends CharacterBody3D

const fall_gravity = 9.8

#export variables for movement changes
@export var running_movement_speed := 400

var is_player = true

@onready var ground = $GroundCast
@onready var model = $Model


func _physics_process(delta):
	#input into a vector
	var input_dir = Vector3(0,0,0)
	input_dir.x += Input.get_axis("move_l","move_r")
	input_dir.z += Input.get_axis("move_f","move_b")
	#rotate input vector based on camera rotation
	input_dir = input_dir.rotated(Vector3.UP, GameData.cam_rotation)
	
	#gravity
	if ground.is_colliding():
		velocity.y = 0.0
	velocity.y -= fall_gravity * delta
	
	#make movement vector
	var move_dir = input_dir.normalized() * get_move_speed(input_dir.length())  * delta
	#smoothen movement
	velocity.x = lerp(velocity.x,move_dir.x, 0.2)
	velocity.z = lerp(velocity.z,move_dir.z, 0.2)
	#apply movement
	move_and_slide()
	
	#Rotate the model to face movement direction
	model.rotate_to_movement(input_dir.normalized())
	#send data
	GameData.player_position = global_position
	GameData.player_move_direction = input_dir.normalized()

#move speed varying on input length
func get_move_speed(input_length):
	var speed :float
	if input_length >= 0.75:
		speed = running_movement_speed
	else:
		speed =  (running_movement_speed+50) * input_length +50

	return speed

