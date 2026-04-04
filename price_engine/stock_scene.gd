extends Node

@export var volatility: float = 10.0
@export var price: float = 0
var stock: Stock

func _ready():
    stock = Stock.new()
    pass

func _on_timer_timeout() -> void:
    print_debug("current", stock.current_function, "price", price)
    stock.reroll_out()    
    price += stock.get_next_diff(volatility)

