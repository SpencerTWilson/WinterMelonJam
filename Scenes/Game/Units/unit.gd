extends TeamObj
class_name Unit

@export var attack_timer: Timer
@export var attack_dmg: float

@export var value: int
@export var movement_speed: float = 25
var movement: Vector2 = Vector2.ZERO

var collision: KinematicCollision2D

@export var spawn_rate: float #Is period so number of seconds til a unit

@export var death_sounds: Array

func _ready() -> void:
	super._ready()
	modulate.a = 0
	spawn_anim_timer.timeout.connect(_finish_fade_in)
	if !blue_team:
		set_collision_layer_value(1, false)
		set_collision_layer_value(2, true)
		
		set_collision_mask_value(1, true)
		set_collision_mask_value(2, false)
		
		primary_sprite.flip_h = true

var death_anim_timer: SceneTreeTimer = null
@onready var spawn_anim_timer: SceneTreeTimer = get_tree().create_timer(0.5)

@export var wiggle_amplitude: float = 1.5
@export var wiggle_speed: float = 0.3
var wiggle_up: bool = true

func _process(delta: float) -> void:
	super._process(delta)
	if death_anim_timer != null:
		var final_rot = PI/2
		if blue_team: final_rot *= -1
		rotation = remap(death_anim_timer.time_left, 0.5, 0, 0, final_rot)
		modulate.a = remap(death_anim_timer.time_left, 0.5, 0, 1, 0)
	if spawn_anim_timer.time_left > 0:
		modulate.a = remap(spawn_anim_timer.time_left, 0.5, 0, 0, 1)

	if movement.x != 0:
		if wiggle_up:
			$Sprite.position.y = lerpf($Sprite.position.y,wiggle_amplitude,wiggle_speed)
		else:
			$Sprite.position.y = lerpf($Sprite.position.y,-wiggle_amplitude,wiggle_speed)
		if is_equal_approx(wiggle_amplitude, $Sprite.position.y) or is_equal_approx(-wiggle_amplitude, $Sprite.position.y):
			wiggle_up = !wiggle_up

func _finish_fade_in():
	modulate.a = 1

func _on_death():
	#gold
	var game_manager:GameManager = get_tree().get_first_node_in_group("GameManager")
	if blue_team: 
		game_manager.red_team_gold += value
		game_manager.collect("red")
	else: 
		game_manager.blue_team_gold += value
		game_manager.collect("blue")
	game_manager.your_gold += value
	game_manager.collect("you")
	#anim
	AudioManager._play_random_clip(death_sounds, "SFX")
	death_anim_timer = get_tree().create_timer(0.5)
	death_anim_timer.timeout.connect(_remove_dead)
	
func _remove_dead():
	queue_free()
