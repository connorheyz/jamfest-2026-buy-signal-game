extends Resource
class_name GameState

var owned_stocks: Array[float]
var holdings: Array[float]
var day_opens: Array[float]
var day_closes: Array[float]

var day: int

var trading_profit: float

var money: float

func _init(d_trading_profit: float=0):
	trading_profit = d_trading_profit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
