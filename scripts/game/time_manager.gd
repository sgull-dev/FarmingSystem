extends Node

signal tick

@export var tick_time: float = 0.1

var time_from_last_tick: float


func _process(delta):
	#tick every tick_time (s)
	time_from_last_tick +=  delta
	if time_from_last_tick >= tick_time:
		time_from_last_tick = 0.0
		tick.emit()

