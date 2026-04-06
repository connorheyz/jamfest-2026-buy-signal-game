extends TextureRect


func _process(delta: float) -> void:
	position.x = get_global_mouse_position().x / 4 + 600
	if (position.x < 650): position.x = 650
	elif (position.x > 800): position.x = 800
