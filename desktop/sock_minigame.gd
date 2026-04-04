extends Control
class_name StockMinigame

@export var stock_ticker: StockTicker
var current_time: float = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%TickTimer.timeout.connect(_on_tick_timeout)

func _on_tick_timeout() -> void:
	var diff: float = (randi() % 50) - 25
	if stock_ticker.prices.size() < 1:
		stock_ticker.append_price(Price.new(diff, current_time))
	else:
		stock_ticker.append_price(Price.new(stock_ticker.prices[-1].price + diff, current_time))
	if diff > 0:
		stock_ticker.set_color(Color.GREEN_YELLOW)
	else:
		stock_ticker.set_color(Color.RED)
	current_time += 1
	%TickTimer.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
