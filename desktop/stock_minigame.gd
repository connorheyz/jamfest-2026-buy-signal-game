extends Control
class_name StockMinigame

@export var stock_ticker: StockTicker
@export var results_screen: PackedScene
var current_tick: float = 1

var current_time: int = 0

var bought_price: float = 0

var day_closed: bool = false

var profit := 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%TickTimer.timeout.connect(_on_tick_timeout)
	%TickerLabel.text = "VTI"
	%HalfHourTimer.timeout.connect(_advance_time)
	%Clock.update_time_label(current_time)
	stock_ticker.append_price(Price.new(PlayerSaveState.previous_day_close, 0))
	
func _advance_time() -> void:
	current_time += 1
	%Clock.update_time_label(current_time)
	if current_time < 13:
		%HalfHourTimer.start()
	else:
		end_day()
		
	
func end_day() -> void:
	%TickTimer.stop()
	%HalfHourTimer.stop()
	day_closed = true
	var day_save: GameState = GameState.new(profit)
	PlayerSaveState.current_money += profit
	PlayerSaveState.game_states.append(day_save)
	get_tree().change_scene_to_packed(results_screen)
	
func get_holding() -> bool:
	return PlayerSaveState.holding
	
func set_holding(value: bool) -> void:
	PlayerSaveState.holding = value
	
	
func _input(event):
	if event.is_action_pressed("buy"):
		if not get_holding() and not day_closed:
			bought_price = stock_ticker.get_latest_price().price
			set_holding(true)
	elif event.is_action_pressed("sell"):
		if get_holding() and not day_closed:
			profit += stock_ticker.get_latest_price().price - bought_price
			update_profit_label()
			set_holding(true)
			
func update_profit_label():
	%ProfitLabel.text = "Day Change: $" + str(profit)

func _on_tick_timeout() -> void:
	var diff: float = (randi() % 50) - 25
	if stock_ticker.prices.size() < 1:
		stock_ticker.append_price(Price.new(diff, current_tick))
		bought_price = diff
	else:
		stock_ticker.append_price(Price.new(stock_ticker.prices[-1].price + diff, current_tick))
	var latest_price: Price = stock_ticker.get_latest_price()
	
	if latest_price.price > bought_price:
		stock_ticker.set_color(Color.GREEN_YELLOW)
	else:
		stock_ticker.set_color(Color.RED)
	current_tick += 1
	%TickTimer.start()
