extends Control
class_name StockMinigame

@export var stock_ticker: StockTicker
var current_tick: float = 0

var current_time: int = 0

var bought_price: float = 0
var holding: bool = false

var day_closed: bool = false

var profit := 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%TickTimer.timeout.connect(_on_tick_timeout)
	%TickerLabel.text = "VTI"
	%HalfHourTimer.timeout.connect(_advance_time)
	%Clock.update_time_label(current_time)
	
func _advance_time() -> void:
	current_time += 1
	%Clock.update_time_label(current_time)
	if current_time < 13:
		%HalfHourTimer.start()
	else:
		%TickTimer.stop()
		%HalfHourTimer.stop()
		day_closed = true
	
	
func _input(event):
	if event.is_action_pressed("buy"):
		if not holding and not day_closed:
			bought_price = stock_ticker.get_latest_price().price
			holding = true
	elif event.is_action_pressed("sell"):
		if holding and not day_closed:
			profit += stock_ticker.get_latest_price().price - bought_price
			update_profit_label()
			holding = false 
			
func update_profit_label():
	%ProfitLabel.text = "Day Change: $" + str(profit)

func _on_tick_timeout() -> void:
	var diff: float = (randi() % 50) - 25
	if stock_ticker.prices.size() < 1:
		stock_ticker.append_price(Price.new(diff, current_tick))
	else:
		stock_ticker.append_price(Price.new(stock_ticker.prices[-1].price + diff, current_tick))
	if diff > 0:
		stock_ticker.set_color(Color.GREEN_YELLOW)
	else:
		stock_ticker.set_color(Color.RED)
	current_tick += 1
	%TickTimer.start()
