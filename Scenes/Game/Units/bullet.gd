extends Node2D

@export var speed: float
var target: Node2D

var flip: bool = false

func _ready() -> void:
	if flip:
		$Sprite2D.flip_h = true

func _process(delta: float) -> void:
	if target == null:
		queue_free()
		return
	if target is Unit:
		if target.death_anim_timer != null:
			if target.death_anim_timer.time_left <= 0.49:
				queue_free()
				return
	global_position = lerp(global_position, target.global_position, speed)
	
	if global_position.distance_to(target.global_position) <= 0.1:
		queue_free()
