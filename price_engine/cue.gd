extends Resource
class_name Cue

var function: Stock.FunctionType
var volatility: float
var start_ticks: int
var duration_ticks: int

func _init(p_function: Stock.FunctionType, p_volatility: float, p_start_ticks: int, p_duration_ticks: int):
    function = p_function
    volatility = p_volatility
    start_ticks = p_start_ticks
    duration_ticks = p_duration_ticks
