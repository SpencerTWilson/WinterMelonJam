extends HBoxContainer

var cur_page_num: int = 0

@export var images: Array[Texture2D] = []
var text: Array[String] = [
	"[center]You are a greedy war profiteer.[/center]",
	"[center]This is the blue base.[/center]",
	"[center]This is the red base.[/center]",
	"[center]They have been polarized against each other.\nwhich is good for business![/center]",
	"[center]The red base acted first, by sending out a troop.[/center]",
	"[center]Both bases will send these troops at each other.[/center]",
	"[center]You make money for each troop created.[/center]",
	"[center]You can influence the battle by playing cards onto the troops of either team.[/center]",
	"[center]You need them to keep fighting to make more profit.\nSo don't let either side win![/center]",
	"[center]You can buy more cards from the grey deck.[/center]",
	"[center]The bases will spend their money on upgrades such as;\nunlocking new units or upgrading their recruitment times.[/center]",
	"[center]They earn more money the closer to the enemy base that they make the kill.[/center]",
	"[center]You earn more score for how far from the center the kill is made.[/center]",
	"[center]You also get 100 score per second of continous fighting.[/center]",
	"[center]Good Luck! Continue reading for unit and card stats![/center]",
	"[center]Direct Damage\n instantly kills the unit.[/center]",
	"[center]Direct Health\n instantly adds the unit's max health.[/center]",
	"[center]Increase Attack Damage\n increases attack damage by 5 damage for the unit.[/center]",
	"[center]Speed Increase\n doubles the speed of the unit.[/center]",
	"[center]Melee\nHP: 10\nSPD: 25\nATK: 5\nVALUE: 1[/center]",
	"[center]Ranged\nHP: 8\nSPD: 35\nATK: 1\nVALUE: 2[/center]",
	"[center]Helicopter\nHP: 35\nSPD: 50\nATK: 5\nVALUE: 4[/center]",
	"[center]Anti-Air Tank\nHP: 15\nSPD: 25\nATK: 20\nVALUE: 2[/center]",
	"[center]Tank\nHP: 50\nSPD: 20\nATK: 10\nVALUE: 5[/center]",
]

func _ready() -> void:
	_update_page()

func _update_page():
	$VBoxContainer/TextureRect.texture = images[cur_page_num]
	$VBoxContainer/Description.text = text[cur_page_num]

func _on_left_button_pressed() -> void:
	if cur_page_num <= 0:
		return
	cur_page_num -= 1
	_update_page()

func _on_right_button_pressed() -> void:
	if cur_page_num >= images.size() - 1:
		return
	cur_page_num += 1
	_update_page()
