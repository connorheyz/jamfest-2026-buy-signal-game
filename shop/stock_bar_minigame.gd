extends HBoxContainer

@export var stock_bar: StockTicker
@export var stock: Stock

@export var stock_ticker: Label
@export var stock_price: Label

@export var trade_button: Button
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var price = 0
	if stock.ticker in PlayerSaveState.previous_day_prices:
		for i in range(len(PlayerSaveState.previous_day_prices[stock.ticker])):
			stock_bar.append_price(Price.new(PlayerSaveState.previous_day_prices[stock.ticker][i] - PlayerSaveState.previous_day_prices[stock.ticker][0], i))
	else:
		print("stock:" + stock.ticker)
		print(stock.volatility)
		print(stock.background_volatility)
		var open_price = PlayerSaveState.stock_prices[stock.ticker]
		PlayerSaveState.previous_day_prices[stock.ticker] = []
		for i in range(300):
			stock_bar.append_price(Price.new(price, i))
			var diff = stock.get_next_diff()
			print(diff)
			price = max(0, price + diff)
			open_price = max(0, diff + open_price)
			PlayerSaveState.previous_day_prices[stock.ticker].append(open_price)
		print("changing price!")
		print(open_price)
		PlayerSaveState.stock_prices[stock.ticker] = open_price
	if stock_bar.prices[-1].price > stock_bar.prices[0].price:
		stock_bar.set_color(Color.GREEN_YELLOW)
	stock_price.text = "$" + ('%.2f' % (PlayerSaveState.stock_prices[stock.ticker] * PlayerSaveState.holdings[stock.ticker]))
	stock_ticker.text = stock.ticker
	trade_button.pressed.connect(_trade_button)

func _trade_button() -> void:
	PlayerSaveState.current_stock = stock
	PlayerSaveState.holding = true
	get_tree().change_scene_to_file("res://desktop/minigame.tscn")
	
