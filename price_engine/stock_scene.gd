extends Node

@export var volatility: float = 10.0
@export var price: float = 0
var stock: Stock

func _ready():
	stock = Stock.new()
	# stock.queue_up(Stock.FunctionType.LINEAR, 50, 5, 4)
	# stock.queue_up(Stock.FunctionType.LINEAR, -100, 10, 7)
	pass

func _on_timer_timeout() -> void:
	print_debug("current", stock.current_function, "price", price)
	stock.reroll_out()
	price += stock.get_next_diff()
