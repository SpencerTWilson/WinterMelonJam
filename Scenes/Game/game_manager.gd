extends Node
class_name GameManager

@export var blue_team_spawn_manager: Node
@export var red_team_spawn_manager: Node

@export var blue_gold_display: RichTextLabel
@export var red_gold_display: RichTextLabel
@export var your_gold_display: RichTextLabel

@export var blue_gold_icon: TextureRect
@export var red_gold_icon: TextureRect
@export var your_gold_icon: TextureRect

@export var gameover_display: Control

@export var units: Array

@export var unit_unlock_costs: Array[int]
@export var ranged_cost: int
@export var tank_cost: int
@export var helecopter_cost: int

@export var buy_audio: AudioStream
@export var collect_audio: AudioStream

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
	for i in range(unit_unlock_costs.size()):
		if blue_team_gold >= unit_unlock_costs[i] and !blue_team_spawn_manager.unlocked_units.has(units[i+1]):
			blue_team_spawn_manager.unlocked_units[units[i+1]] = null
			blue_team_gold -= unit_unlock_costs[i]
			AudioManager._play_clip(buy_audio,"SFX")
		if red_team_gold >= unit_unlock_costs[i] and !red_team_spawn_manager.unlocked_units.has(units[i+1]):
			red_team_spawn_manager.unlocked_units[units[i+1]] = null
			red_team_gold -= unit_unlock_costs[i]
			AudioManager._play_clip(buy_audio,"SFX")

func collect(who: String):
	AudioManager._play_clip(collect_audio, "SFX")
	match who:
		"red":
			red_gold_icon.collect()
		"blue":
			blue_gold_icon.collect()
		"you":
			your_gold_icon.collect()
