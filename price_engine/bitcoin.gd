extends Stock

class_name Bitcoin

func _init() -> void:
	functions = [StockFunction.new(), Linear.new()]
	current_function = 0
	rng = RandomNumberGenerator.new()
	cue_queue = []
	dont_change = 0
	volatility = 100.0
	background_volatility = 100.0
	function_weights = [10, 3]
	function_gammas = [0.07, 0.2]


