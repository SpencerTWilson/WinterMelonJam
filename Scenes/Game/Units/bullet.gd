extends Node2D

@export var speed: float
var target: Node2D

func _process(delta: float) -> void:
	if target == null:
		queue_free()
		return
	global_position = lerp(global_position, target.global_position, speed)
	
	if global_position.is_equal_approx(target.global_position):
		queue_free()
