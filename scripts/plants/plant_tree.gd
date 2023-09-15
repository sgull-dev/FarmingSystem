extends Node3D


func _ready():
	#Randomize the tree rotation on spawn.
	rotation.y = deg_to_rad(randf_range(0.0, 360.0))
