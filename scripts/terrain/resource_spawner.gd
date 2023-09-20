extends Node3D

var resources = [
	preload("res://scenes/interactables/stone.tscn"),
	preload("res://scenes/interactables/twig.tscn"),
]


func scatter_resources(area: Vector2, amount_to_scatter):
	#Scatters random resources from the resource array into an area.
	#create holder node under stage
	var holder = Node3D.new()
	GameData.get_current_stage().add_child.call_deferred(holder)
	#Spawn resources
	for r in amount_to_scatter:
		#pick random resource
		var index = randi()%resources.size()
		var resource = resources[index].instantiate()
		holder.add_child(resource)
		#set random position
		var pos_x = randf_range(-area.x/2 +1, area.x/2 -1)
		var pos_z = randf_range(-area.y/2 +1, area.y/2 -1)
		resource.position = Vector3(pos_x, 0, pos_z)
		#set random rotation
		resource.rotation_degrees.y = randf_range(0.0, 360.0)
