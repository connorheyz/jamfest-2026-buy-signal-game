extends HBoxContainer

@export var stock_bar: StockTicker
@export var stock: Stock

@export var stock_ticker: Label
@export var stock_price: Label

@export var buy_ten: Button
@export var buy_one: Button
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var price = 0
	if stock.ticker in PlayerSaveState.previous_day_prices:
		for i in range(len(PlayerSaveState.previous_day_prices[stock.ticker])):
			stock_bar.append_price(Price.new((PlayerSaveState.previous_day_prices[stock.ticker][i] - PlayerSaveState.previous_day_prices[stock.ticker][0])/PlayerSaveState.previous_day_prices[stock.ticker][0], i))
	else:
		var open_price = PlayerSaveState.stock_prices[stock.ticker]
		PlayerSaveState.previous_day_prices[stock.ticker] = []
		for i in range(150):
			stock_bar.append_price(Price.new(price, i))
			var diff = stock.get_next_diff()
			price = max(0, price + diff)
			open_price = max(0, diff + open_price)
			PlayerSaveState.previous_day_prices[stock.ticker].append(open_price)
		PlayerSaveState.stock_prices[stock.ticker] = open_price
	if stock_bar.prices[-1].price > stock_bar.prices[0].price:
		stock_bar.set_color(Color.GREEN_YELLOW)
	stock_price.text = "$" + ('%.2f' % PlayerSaveState.stock_prices[stock.ticker])
	stock_ticker.text = stock.ticker
	buy_ten.pressed.connect(_attempt_buy_ten)
	buy_one.pressed.connect(_attempt_buy_one)
	
func _attempt_buy_ten() -> void:
	if PlayerSaveState.current_money > PlayerSaveState.stock_prices[stock.ticker] * 10:
		if stock.ticker in PlayerSaveState.holdings:
			PlayerSaveState.holdings[stock.ticker] += 10
		else:
			PlayerSaveState.holdings[stock.ticker] = 10
		if stock not in PlayerSaveState.portfolio:
			PlayerSaveState.portfolio.append(stock)
		PlayerSaveState.current_money -= PlayerSaveState.stock_prices[stock.ticker] * 10
		$SFXPlayer.stream = load("res://test/kaching1.mp3")
		$SFXPlayer.play()
	else:
		$SFXPlayer.stream = load("res://test/fail.mp3")
		$SFXPlayer.play()
	
func _attempt_buy_one() -> void:
	if PlayerSaveState.current_money > PlayerSaveState.stock_prices[stock.ticker]:
		if stock.ticker in PlayerSaveState.holdings:
			PlayerSaveState.holdings[stock.ticker] += 1
		else:
			PlayerSaveState.holdings[stock.ticker] = 1
		if stock not in PlayerSaveState.portfolio:
			PlayerSaveState.portfolio.append(stock)
		PlayerSaveState.current_money -= PlayerSaveState.stock_prices[stock.ticker]
		$SFXPlayer.stream = load("res://test/kaching1.mp3")
		$SFXPlayer.play()
	else:
		$SFXPlayer.stream = load("res://test/fail.mp3")
		$SFXPlayer.play()
