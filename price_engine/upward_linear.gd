extends StockFunction

class_name UpwardLinear

func get_next_diff(volatility: float) -> float:
    var rng := RandomNumberGenerator.new()
    return rng.randf() * volatility
