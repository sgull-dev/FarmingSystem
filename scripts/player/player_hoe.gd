extends Node3D

@onready var anim = $AnimationPlayer
@onready var hoe_cast = $RayCast3D


func _input(event):
	if event.is_action("use_item"):
		swing_hoe()


func swing_hoe():
	print("Swinging hoe.")
	#anim
	anim.play("SwingHoe")
	#cast
	hoe_cast.force_raycast_update()
	var collider = hoe_cast.get_collider()
	if !collider == null:
		print("Raycast found something.")
		print(collider)
		if "is_block" in collider.get_node(".."):
			print("Body was block.")
			collider.get_node("..").till_block()
