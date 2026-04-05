extends Node
class_name PlayerSave

var game_states: Array[GameState]

var current_money: float = 1000

var current_day: int = 0

var holdings: = {}

var stock_prices: = {}

var items: Array[SwagItem]

var previous_day_close: float

@export var unlocked_items: Array[SwagItem]
@export var unlocked_stocks: Array[Stock]

func _ready() -> void:
	stock_prices["VTI"] = 100;

var holding: bool
