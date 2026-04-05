extends Node

@export var price: float = 0
var stock: Stock

func _ready():
	stock = Bitcoin.new()
#	stock.queue_up(Stock.FunctionType.LINEAR, 50, 5, 4)
#	stock.queue_up(Stock.FunctionType.LINEAR, -100, 10, 7)
	pass

func _on_timer_timeout() -> void:
	do_tick()

func do_tick() -> float:
	# print_debug("current", stock.current_function, "price", price)
	stock.reroll_out()
	var diff := stock.get_next_diff()
	price += diff
	return diff

func queue_up(function_type: Stock.FunctionType, p_volatility: float, start_ticks: int, duration_ticks: int) -> void:
	stock.queue_up(function_type, p_volatility, start_ticks, duration_ticks)

func set_stock(new_stock: Stock) -> void:
	stock = new_stock
