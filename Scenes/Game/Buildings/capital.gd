extends StaticBody2D

@export var blue_team: bool = false

@export var health_max: float = 100
@onready var cur_health: float = health_max

@export var healthbar : Sprite2D

func _ready():
	healthbar.material = healthbar.material.duplicate()

func _process(delta):
	healthbar.material.set_shader_parameter("value", cur_health / health_max)
	cur_health -= 10 * delta
