extends StockFunction

class_name Linear

func get_next_diff(volatility: float) -> float:
	var rng := RandomNumberGenerator.new()
	return rng.randf() * volatility * 2
