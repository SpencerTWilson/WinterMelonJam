extends Node

@export var card_slot: CardSlot
@export var unit: Unit

func _ready() -> void:
	card_slot.slot_selected.connect(_card_dropped)

func _card_dropped(card: Card, _from_deck: bool):
	for type in card.tags:
		match type:
			"heal":
				unit.cur_health += 10
			"buff":
				unit.attack_dmg += 5
			"dmg":
				unit.cur_health -= 10
	card.queue_free()
