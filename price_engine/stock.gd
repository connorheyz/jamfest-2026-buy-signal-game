extends Resource
class_name Stock

var functions: Array[StockFunction]
var function_weights: Array[float] ## weight of entering function
var function_gammas: Array[float] ## chance of exiting function on every reroll(0 < k < 1)
var current_function: int
var rng: RandomNumberGenerator

func _init() -> void:
	functions = [StockFunction.new(), Linear.new()]
	function_weights = [3, 6, 5]
	function_gammas = [0.3, 0.2, 0.4]
	current_function = 0
	rng = RandomNumberGenerator.new()

## call on regular interval to check whether to leave the current function
func reroll_out() -> void:
	var roll := rng.randf()
	print_debug("reroll", roll)
	if roll > function_gammas[current_function]:
		return
	reroll_in()

## When a new function is being chosen, call to return new index
func reroll_in() -> void:
	current_function = rng.rand_weighted(function_weights)

func get_next_diff(volatility: float) -> float:
	return functions[current_function].get_next_diff(volatility)
