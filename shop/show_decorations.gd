extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for item in PlayerSaveState.items:
		match item.name:
			"Cat Headphones":
				$Headphones.visible = true
			"\"Your Name\" Mug":
				$YourNameMug.visible = true
			"Faux-mon Cards":
				$Cards.visible = true
			"Diamond Hands":
				$DiamondHands.visible = true
			"K-pop Demon Slayers Poster":
				$Poster.visible
				


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
