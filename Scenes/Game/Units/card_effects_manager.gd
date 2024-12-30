extends Node

@export var card_slot: CardSlot
@export var unit: Unit

func _ready() -> void:
	card_slot.slot_selected.connect(_card_dropped)

func _card_dropped(card: Card, _from_deck: bool):
	for type in card.tags:
		match type:
			"heal":
				$Plus.emitting = true
				unit.cur_health += unit.max_health
			"buff":
				$Buff.emitting = true
				unit.attack_dmg += 5
			"dmg":
				$Minus.emitting = true
				unit._damage(unit.cur_health)
			"spd":
				$Spd.emitting = true
				unit.movement_speed += unit.movement_speed
	card_slot._remove_card(card)
	card.queue_free()
