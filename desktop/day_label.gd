extends Label

func _ready() -> void:
	text = Utils.int_to_day(PlayerSaveState.current_day)
