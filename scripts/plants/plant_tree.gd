extends Node3D


func _ready():
	rotation.y = deg_to_rad(randf_range(0.0, 360.0))
