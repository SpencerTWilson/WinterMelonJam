extends Sprite2D

@export var game_manager: GameManager

var current_card_cost: int = 5

@export var denied_sound: AudioStream
@export var buy_sound: AudioStream

func _on_area_2d_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("select"):
		print("oh yeah!")
		if game_manager.your_gold >= current_card_cost:
			AudioManager._play_clip(buy_sound, "SFX")
			summon_card_to_hand()
			current_card_cost += 5
		else:
			AudioManager._play_clip(denied_sound, "SFX")

func summon_card_to_hand():
	pass
