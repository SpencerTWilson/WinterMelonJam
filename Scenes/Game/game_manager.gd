extends Node
class_name GameManager

@export var blue_team_spawn_manager: Node
@export var red_team_spawn_manager: Node

@export var blue_gold_display: RichTextLabel
@export var red_gold_display: RichTextLabel
@export var your_gold_display: RichTextLabel

@export var gameover_display: Control

@export var units: Array

@export var ranged_cost: int
@export var tank_cost: int

var blue_team_gold: int = 0
var red_team_gold: int = 0
var your_gold: int = 0

func _ready() -> void:
	blue_team_spawn_manager.unlocked_units[units[0]] = null
	red_team_spawn_manager.unlocked_units[units[0]] = null

func _process(_delta: float) -> void:
	blue_gold_display.text = "%d" % blue_team_gold
	red_gold_display.text = "[right]%d[/right]" % red_team_gold
	your_gold_display.text = "%d" % your_gold

func _game_over():
	#get_tree().paused = true #Commented out cause it's cooler to have stuff still happen in the back but if we experiance bugs uncomment
	gameover_display.visible = true

func _on_buy_tank_timer_timeout() -> void:
	if blue_team_gold >= ranged_cost and !blue_team_spawn_manager.unlocked_units.has(units[1]):
		blue_team_spawn_manager.unlocked_units[units[1]] = null
		blue_team_gold -= ranged_cost
	if red_team_gold >= ranged_cost and !red_team_spawn_manager.unlocked_units.has(units[1]):
		red_team_spawn_manager.unlocked_units[units[1]] = null
		red_team_gold -= ranged_cost
	
	if blue_team_gold >= tank_cost and !blue_team_spawn_manager.unlocked_units.has(units[2]):
		blue_team_spawn_manager.unlocked_units[units[2]] = null
		blue_team_gold -= tank_cost
	if red_team_gold >= tank_cost and !red_team_spawn_manager.unlocked_units.has(units[2]):
		red_team_spawn_manager.unlocked_units[units[2]] = null
		red_team_gold -= tank_cost
