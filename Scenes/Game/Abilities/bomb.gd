extends Sprite2D

@export var boom_sound: AudioStream

@export var wiggle_amplitude: float = 1.5
@export var wiggle_speed: float = 0.3
var wiggle_right: bool
var drop_velocity: float = 0.1

func _process(delta: float) -> void:
	drop_velocity += drop_velocity/10
	position.y += drop_velocity
	
	if wiggle_right:
		position.x = lerpf(position.x,wiggle_amplitude,wiggle_speed)
	else:
		position.x = lerpf(position.x,-wiggle_amplitude,wiggle_speed)
	if is_equal_approx(wiggle_amplitude, position.x) or is_equal_approx(-wiggle_amplitude, position.x):
		wiggle_right = !wiggle_right

var done = false

func _on_boom_timer_timeout() -> void:
	if !done: AudioManager._play_clip(boom_sound,"SFX")
	texture = null
	$BoomTimer.start()
	if done: queue_free()
	done = true
