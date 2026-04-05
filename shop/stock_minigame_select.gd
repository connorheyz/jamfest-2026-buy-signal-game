extends VBoxContainer
class_name StockMinigameSelect

var stock_item_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stock_item_scene = preload("res://shop/stock_bar_minigame.tscn")
	var stocks = PlayerSaveState.portfolio
	for stock in stocks:
		var stock_item = stock_item_scene.instantiate()
		stock_item.stock = stock
		add_child(stock_item)
