extends Resource
class_name Stock

var functions: Array[StockFunction]
var function_weights: Array[float] ## weight of entering function
var function_gammas: Array[float] ## chance of exiting function on every reroll(0 < k < 1)
var current_function: int
var rng: RandomNumberGenerator
var cue_queue: Array[Cue]
var dont_change: int ## number of ticks to wait until rerolling out again; set by active cue
var volatility: float
var background_volatility: float

enum FunctionType {
	RANDOM,
	LINEAR,
}

func _init() -> void:
	functions = [StockFunction.new(), Linear.new()]
	function_weights = [6, 3]
	function_gammas = [0.3, 0.2]
	current_function = 0
	rng = RandomNumberGenerator.new()
	cue_queue = []
	dont_change = 0
	volatility = 10.0
	background_volatility = -10.0

## call on regular interval to check whether to leave the current function
func reroll_out() -> void:
	if len(cue_queue) > 0:
		print_debug("queue", cue_queue)
		for cue_index in range(len(cue_queue) - 1, -1, -1):
			var cue: Cue = cue_queue[cue_index]
			if cue.start_ticks == 0:
				# apply cue
				print_debug("Applying cue")
				dont_change = cue.duration_ticks
				cue_queue.remove_at(0)
				current_function = cue.function
				volatility = cue.volatility
				dont_change = cue.duration_ticks
			else:
				# move start_ticks forward
				cue_queue[cue_index].start_ticks -= 1
	
	if dont_change > 1:
		dont_change -= 1
		if dont_change == 1:
			volatility = background_volatility	
		return
				
	var roll := rng.randf()
	# print_debug("reroll", roll)
	if roll > function_gammas[current_function]:
		return
	reroll_in()

## When a new function is being chosen, call to return new index
func reroll_in() -> void:
	current_function = rng.rand_weighted(function_weights)

func get_next_diff() -> float:
	return functions[current_function].get_next_diff(volatility)

func queue_up(function: FunctionType, volatility: float, start_ticks: int, duration_ticks: int) -> void:
	cue_queue.append(Cue.new())
	cue_queue[-1].function = function
	cue_queue[-1].volatility = volatility
	cue_queue[-1].start_ticks = start_ticks
	cue_queue[-1].duration_ticks = duration_ticks 
	cue_queue.sort_custom(func(x, y): (x.start_ticks < y.start_ticks))
