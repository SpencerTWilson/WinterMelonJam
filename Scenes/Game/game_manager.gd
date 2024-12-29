extends Node
class_name GameManager

var score: int = 0

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

@export var blue_spawn_speed_upgrade_cost: int
@export var red_spawn_speed_upgrade_cost: int
@export var upgrade_cost_increase: int

var blue_team_gold: int = 0
var red_team_gold: int = 0
var your_gold: int = 0

var team_winning_value: float = 0.5

func _ready() -> void:
	blue_team_spawn_manager.unlocked_units[units[0]] = null
	red_team_spawn_manager.unlocked_units[units[0]] = null

func _process(_delta: float) -> void:
	#Text
	blue_gold_display.text = "%d" % blue_team_gold
	red_gold_display.text = "[right]%d[/right]" % red_team_gold
	your_gold_display.text = "%d" % your_gold
	
	$CanvasLayer/CoinDisplays2/BlueLvl.text = "LVL: %d" % blue_base_lvl
	$CanvasLayer/CoinDisplays2/RedLvl.text = "[right]LVL: %d[/right]" % red_base_lvl
	
	#Calc Team Fight Winning status
	var furethest_blue_unit = get_furthest_troop(blue_team_spawn_manager)
	var furethest_red_unit = get_furthest_troop(red_team_spawn_manager)
	
	team_winning_value = ((1 - (furethest_blue_unit.position.x / -838)) + (furethest_red_unit.position.x / 838))/2
	$CanvasLayer/ColorRect/Blue1.amount_ratio = remap(clampf(1 - team_winning_value, 0.5, 1), 0.5, 1, 0, 1)
	$CanvasLayer/ColorRect/Blue2.amount_ratio = remap(clampf(1 - team_winning_value, 0.5, 1), 0.5, 1, 0, 1)
	$CanvasLayer/ColorRect/Red1.amount_ratio = remap(clampf(team_winning_value, 0.5, 1), 0.5, 1, 0, 1)
	$CanvasLayer/ColorRect/Red2.amount_ratio = remap(clampf(team_winning_value, 0.5, 1), 0.5, 1, 0, 1)
	$CanvasLayer/ColorRect.material.set_shader_parameter("value",lerp($CanvasLayer/ColorRect.material.get_shader_parameter("value"), team_winning_value, 0.10))
	
func get_furthest_troop(parent_node: Node2D):
	var furthest_unit: Node2D = parent_node
	for child in parent_node.get_children():
		if child is Unit:
			if abs(child.position.x) > abs(furthest_unit.position.x):
				furthest_unit = child
	return furthest_unit
	
func _game_over():
	#get_tree().paused = true #Commented out cause it's cooler to have stuff still happen in the back but if we experiance bugs uncomment
	$CanvasLayer/GameOverPanel/VBoxContainer/ScoreText.text = "\n[center]Score %d[/center]" % score
	gameover_display.visible = true

var blue_base_lvl: int = 0
var red_base_lvl: int = 0

func _on_buy_tank_timer_timeout() -> void:
	var blue_bought_flag: bool = false
	var red_bought_flag: bool = false
	
	#check for more units
	for i in range(unit_unlock_costs.size()):
		if blue_team_gold >= unit_unlock_costs[i] and !blue_team_spawn_manager.unlocked_units.has(units[i+1]):
			blue_team_spawn_manager.unlocked_units[units[i+1]] = null
			blue_team_gold -= unit_unlock_costs[i]
			blue_bought_flag = true
			AudioManager._play_clip(buy_audio,"SFX")
		if red_team_gold >= unit_unlock_costs[i] and !red_team_spawn_manager.unlocked_units.has(units[i+1]):
			red_team_spawn_manager.unlocked_units[units[i+1]] = null
			red_team_gold -= unit_unlock_costs[i]
			red_bought_flag = true
			AudioManager._play_clip(buy_audio,"SFX")
	
	#if we didn't buy a unit consider spawn speed increase
	if !blue_bought_flag and blue_team_gold >= blue_spawn_speed_upgrade_cost:
		blue_team_gold -= blue_spawn_speed_upgrade_cost
		blue_spawn_speed_upgrade_cost += upgrade_cost_increase
		blue_team_spawn_manager.spawn_rate *= .9
		blue_base_lvl += 1
		AudioManager._play_clip(buy_audio,"SFX")
	if !red_bought_flag and red_team_gold >= red_spawn_speed_upgrade_cost:
		red_team_gold -= red_spawn_speed_upgrade_cost
		red_spawn_speed_upgrade_cost += upgrade_cost_increase
		red_team_spawn_manager.spawn_rate *= .9
		red_base_lvl += 1
		
		
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


func _on_timer_timeout() -> void:
	score += 100
