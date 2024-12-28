extends TeamObj
class_name Unit

@export var attack_timer: Timer
@export var attack_dmg: float

@export var value: int
@export var movement_speed: float = 0.5
var movement: Vector2 = Vector2.ZERO

var collision: KinematicCollision2D

@export var spawn_rate: float #Is period so number of seconds til a unit

func _ready() -> void:
	modulate.a = 0
	if !blue_team:
		set_collision_layer_value(1, false)
		set_collision_layer_value(2, true)
		
		set_collision_mask_value(1, true)
		set_collision_mask_value(2, false)
		
		primary_sprite.flip_h = true

func _physics_process(delta: float) -> void:
	#movement
	if !blue_team: movement.x = -movement_speed
	else: movement.x = movement_speed
	movement.x *= delta

	#We save the collision into a var so any unit that needs that info can have it
	collision = move_and_collide(movement)

var death_anim_timer: SceneTreeTimer = null
@onready var spawn_anim_timer: SceneTreeTimer = get_tree().create_timer(0.5)

func _process(delta: float) -> void:
	super._process(delta)
	if death_anim_timer != null:
		var final_rot = PI/2
		if blue_team: final_rot *= -1
		rotation = remap(death_anim_timer.time_left, 0.5, 0, 0, final_rot)
		modulate.a = remap(death_anim_timer.time_left, 0.5, 0, 1, 0)
	if spawn_anim_timer.time_left > 0:
		modulate.a = remap(spawn_anim_timer.time_left, 0.5, 0, 0, 1)

func _on_death():
	#gold
	var game_manager:GameManager = get_tree().get_first_node_in_group("GameManager")
	if blue_team: game_manager.red_team_gold += value
	else: game_manager.blue_team_gold += value
	game_manager.your_gold += value
	#anim
	death_anim_timer = get_tree().create_timer(0.5)
	death_anim_timer.timeout.connect(_remove_dead)
	
func _remove_dead():
	queue_free()
