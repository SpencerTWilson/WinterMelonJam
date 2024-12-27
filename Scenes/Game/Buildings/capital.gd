extends TeamObj

func _on_death():
	var game_manager:GameManager = get_tree().get_first_node_in_group("GameManager")
	game_manager._game_over()
