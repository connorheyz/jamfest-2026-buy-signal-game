extends Label

@export var minigame: StockMinigame
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "Networth: $" + ('%.2f' % (PlayerSaveState.get_networth() + minigame.profit))
