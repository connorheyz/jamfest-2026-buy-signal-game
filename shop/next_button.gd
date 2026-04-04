extends Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_to_next_scene)

func _to_next_scene() -> void:
	PlayerSaveState.current_day += 1
	print(PlayerSaveState.current_day)
	if PlayerSaveState.current_day % 7 < 5:
		print("changing_scene")
		get_tree().change_scene_to_file("res://desktop/minigame.tscn")
	else:
		get_tree().change_scene_to_file("res://desktop/minigame.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
