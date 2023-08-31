extends Node3D

@export var horizontal_follow_lerp := 1.0
@export var vertical_follow_lerp := 1.0

@onready var cam_holder = $CameraHolder
@onready var cam = $CameraHolder/Camera3D

func _process(_delta):
	#send rotation data
	GameData.cam_rotation = cam_holder.rotation.y
	#smooth move to player pos
	cam_holder.position.x = lerp(cam_holder.position.x,GameData.player_position.x, horizontal_follow_lerp)
	cam_holder.position.z = lerp(cam_holder.position.z,GameData.player_position.z, horizontal_follow_lerp)
	cam_holder.position.y = lerp(cam_holder.position.y,GameData.player_position.y, vertical_follow_lerp)

