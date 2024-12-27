extends Node
class_name GameManager

@export var blue_team_spawn_manager: Node
@export var red_team_spawn_manager: Node

@export var units: Array

var blue_team_gold: int = 0
var red_team_gold: int = 0

func _ready() -> void:
	blue_team_spawn_manager.unlocked_units[units[0]] = null
	red_team_spawn_manager.unlocked_units[units[0]] = null

func _game_over():
	print("Game Over!")
