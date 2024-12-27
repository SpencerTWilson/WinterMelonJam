extends CharacterBody2D
class_name TeamObj

@export var blue_team: bool = false

var dead: bool = false
@export var max_health: float = 100
@onready var cur_health: float = max_health

@export var healthbar: Sprite2D

@export var primary_sprite: Sprite2D

func _ready():
	healthbar.material = healthbar.material.duplicate()

func _damage(dmg: float):
	if dead: #He's already dead
		return false #we didn't actually hit
	cur_health -= dmg
	if cur_health <= 0:
		#Just so we display stuff properly
		cur_health = 0 
		dead = true
		_on_death()
	return true

func _process(_delta):
	healthbar.material.set_shader_parameter("value", cur_health / max_health)

func _on_death():
	pass #Implement on specific obj
