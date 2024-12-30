extends Node2D

@export var game_manager: GameManager
@export var hand: CardSlot
@export var cost_display: RichTextLabel

@export var card_scene: PackedScene

@export_file("*.json") var card_data_file: String
var card_data: Dictionary

var current_card_cost: int = 4
var card_level: int = 1

@export var denied_sound: AudioStream
@export var buy_sound: AudioStream

func _ready() -> void:
	var options_json_string: String = FileAccess.get_file_as_string(card_data_file)
	card_data = JSON.parse_string(options_json_string)
	cost_display.text = "[right]-%d[/right]" % current_card_cost
	summon_card_to_hand()
	summon_card_to_hand()
	summon_card_to_hand()

func _on_area_2d_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("select"):
		if game_manager.your_gold >= current_card_cost:
			AudioManager._play_clip(buy_sound, "SFX")
			summon_card_to_hand()
			game_manager.your_gold -= current_card_cost
			current_card_cost += 4
			cost_display.text = "[right]-%d[/right]" % current_card_cost
		else:
			AudioManager._play_clip(denied_sound, "SFX")

func summon_card_to_hand():
	#pick a random card type
	var rand_card_name: String = card_data.keys().pick_random()
	var card_to_spawn: Dictionary = card_data[rand_card_name]
	
	var new_card: Card = card_scene.instantiate()
	new_card.front_texture = load(card_to_spawn["front_texture"])
	new_card.texture = load(card_to_spawn["front_texture"])
	new_card.tags = card_to_spawn["tags"]
	new_card.name = rand_card_name
	new_card.rest_slot = hand
	new_card.rest_slot._select(new_card)
	new_card.flipped = true
	new_card.flipping = true
	add_child(new_card)
