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
	for i in range(30):
		stock_bar.append_price(Price.new(price, i))
		price += stock.get_next_diff()
	if stock_bar.prices[-1].price > stock_bar.prices[0].price:
		stock_bar.set_color(Color.GREEN_YELLOW)
	if stock.ticker not in PlayerSaveState.holdings:
		PlayerSaveState.stock_prices[stock.ticker] += stock_bar.prices[-1].price
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
		PlayerSaveState.current_money -= PlayerSaveState.stock_prices[stock.ticker] * 10
	
func _attempt_buy_one() -> void:
	if PlayerSaveState.current_money > PlayerSaveState.stock_prices[stock.ticker]:
		if stock.ticker in PlayerSaveState.holdings:
			PlayerSaveState.holdings[stock.ticker] += 1
		else:
			PlayerSaveState.holdings[stock.ticker] = 1
		PlayerSaveState.current_money -= PlayerSaveState.stock_prices[stock.ticker]
