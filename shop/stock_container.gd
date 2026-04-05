extends VBoxContainer
class_name StockContainer

var stock_item_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var stocks = PlayerSaveState.unlocked_stocks
	stock_item_scene = preload("res://shop/stock_bar.tscn")
	for stock in stocks:
		var stock_item = stock_item_scene.instantiate()
		stock_item.stock = stock
		add_child(stock_item)
