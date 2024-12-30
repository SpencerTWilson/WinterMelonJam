extends Node2D

@export var game_manager: GameManager
@export var cost_display: RichTextLabel

@export var bomb_scene: PackedScene

@export var current_card_cost: int = 6
var card_level: int = 1

@export var denied_sound: AudioStream
@export var buy_sound: AudioStream

func _ready() -> void:
	cost_display.text = "\n[right]-%d [/right]\n" % current_card_cost

func _on_area_2d_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("select"):
		if game_manager.your_gold >= current_card_cost:
			AudioManager._play_clip(buy_sound, "SFX")
			summon_bomb()
			game_manager.your_gold -= current_card_cost
			current_card_cost += current_card_cost
			cost_display.text = "\n[right]-%d [/right]\n" % current_card_cost
		else:
			AudioManager._play_clip(denied_sound, "SFX")

func summon_bomb():
	game_manager._bomb()
	var new_bomb = bomb_scene.instantiate()
	add_child(new_bomb)
