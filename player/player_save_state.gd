extends Node
class_name PlayerSave

var game_states: Array[GameState]

var current_money: float = 1000

var current_day: int = 0

@export var holdings: = {}
@export var portfolio: Array[Stock]

@export var stock_prices: = {}

var items: Array[SwagItem]

var previous_day_prices:= {}

var previous_day_close: float

var current_stock: Stock

@export var unlocked_items: Array[SwagItem]
@export var unlocked_stocks: Array[Stock]

var holding: bool
