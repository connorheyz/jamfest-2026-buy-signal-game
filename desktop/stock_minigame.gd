extends Control
class_name StockMinigame

@export var stock_ticker: StockTicker
@export var results_screen: PackedScene
var current_tick: float = 1

var current_time: int = 0

var bought_price: float = 0

var day_closed: bool = false

var owned_at_open: int

var stock: Stock

var profit := 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerSaveState.previous_day_prices = {}
	%TickTimer.timeout.connect(_on_tick_timeout)
	%HalfHourTimer.timeout.connect(_advance_time)
	%Clock.update_time_label(current_time)
	stock = PlayerSaveState.current_stock
	owned_at_open = PlayerSaveState.holdings[stock.ticker]
	%TickerLabel.text = stock.ticker
	stock_ticker.append_price(Price.new(PlayerSaveState.stock_prices[stock.ticker], 0))


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
	PlayerSaveState.previous_day_prices[stock.ticker] = []
	for price in stock_ticker.prices:
		PlayerSaveState.previous_day_prices[stock.ticker].append(price.price)
	PlayerSaveState.current_money += profit
	print(stock_ticker.get_latest_price().price)
	PlayerSaveState.stock_prices[stock.ticker] = stock_ticker.get_latest_price().price
	PlayerSaveState.game_states.append(day_save)
	get_tree().change_scene_to_packed(results_screen)
	
func get_holding() -> bool:
	return stock.ticker in PlayerSaveState.holdings and PlayerSaveState.holdings[stock.ticker] != 0
	
func set_holding(value: bool) -> void:
	if value:
		PlayerSaveState.holdings[stock.ticker] = owned_at_open
	else:
		PlayerSaveState.holdings[stock.ticker] = 0
	
func _input(event):
	if event.is_action_pressed("buy"):
		if not get_holding() and not day_closed:
			bought_price = stock_ticker.get_latest_price().price
			set_holding(true)
			%RhythmScene.bought_or_sold()
	elif event.is_action_pressed("sell"):
		if get_holding() and not day_closed:
			profit += stock_ticker.get_latest_price().price - bought_price
			PlayerSaveState.current_money += PlayerSaveState.holdings[stock.ticker] * stock_ticker.get_latest_price().price
			update_profit_label()
			set_holding(true)
			%RhythmScene.bought_or_sold()
			
func update_profit_label():
	%ProfitLabel.text = "Day Change: $" + str(profit)

func _on_tick_timeout() -> void:
	%RhythmScene.do_tick()
	print(stock_ticker.get_latest_price().price)
	var diff: float = %StockScene.do_tick()
	var new_price = max(0, stock_ticker.prices[-1].price + diff)
	stock_ticker.append_price(Price.new(new_price, current_tick))
	var latest_price: Price = stock_ticker.get_latest_price()
	
	if latest_price.price > bought_price:
		stock_ticker.set_color(Color.GREEN_YELLOW)
	else:
		stock_ticker.set_color(Color.RED)
	current_tick += 1
	%TickTimer.start()


func _on_queue_up_menu_button_queue_up_pressed(type: Stock.FunctionType, p_volatility: float, start_ticks: int, duration_ticks: int) -> void:
	%StockScene.queue_up(type, p_volatility, start_ticks, duration_ticks)


func _on_rhythm_scene_enqueue_cue(cue: Cue) -> void:
	%StockScene.queue_up(cue.function, cue.volatility, cue.start_ticks, cue.duration_ticks)
