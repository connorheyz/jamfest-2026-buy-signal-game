extends Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_to_next_scene)

func _to_next_scene() -> void:
	get_tree().change_scene_to_file("res://shop/shop.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
