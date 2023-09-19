extends Node3D


var item_active : bool = false
var can_water : bool = true
var is_watering : bool = false

@onready var anim = $AnimationPlayer
@onready var cast = $RayCast3D
@onready var player_inventory = $"../../../PlayerInventory"


func _process(_delta):
	#if player is holding sickle in hand, activate
	if player_inventory.inventory[player_inventory.active_item_slot].item_name == "watering_can":
		item_active = true
		visible = true
	else:
		item_active = false
		visible = false
		anim.play("RESET")
		can_water = true
	if is_watering:
		if Input.is_action_just_released("use_item"):
			anim.play("StopWatering")
			is_watering = false


func _input(event):
	if event.is_action_pressed("use_item"):
		if can_water and item_active:
			water()


func water():
	#anim
	anim.play("Watering")
	is_watering = true
	#cast
	while is_watering:
		cast.force_raycast_update()
		var collider = cast.get_collider()
		#find collider
		if !collider == null:
			if "is_block" in collider:
				#If the collider is a block and the block's plant_type is correct, attempt to harvest plant
				if collider.ground_mode == collider.GROUND_MODE.TILLED:
					collider.water_level += 10
		$GPUParticles3D/Timer.start(0.25)
		await $GPUParticles3D/Timer.timeout
		if !$GPUParticles3D.emitting:
			$GPUParticles3D.restart()
	
