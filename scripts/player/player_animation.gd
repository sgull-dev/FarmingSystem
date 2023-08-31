extends CSGSphere3D

var look_dir : Vector3 = Vector3(0,0,-1)

func rotate_to_movement(move_dir):
	if move_dir.length() >= 0.1:
		look_dir = look_dir.move_toward(move_dir,0.1)
		var angle = look_dir.signed_angle_to(Vector3(0,0,-1), Vector3(0,-1,0))
		rotation.y = angle
