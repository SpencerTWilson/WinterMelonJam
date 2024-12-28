extends CardSlot

@export var hand_spacing: float = 75

func get_card_pos(card: Card):
	var card_spaced = (cards.find(card) - (cards.size() as float / 2) + 0.5) * hand_spacing
	return global_position + Vector2(card_spaced, 0)

func _select(card: Card, _from_deck: bool = false):
	if card.global_position.x < global_position.x:
		cards.insert(0, card)
	else:
		cards.append(card)
	card.rest_slot = self
