extends Resource

class_name StockFunction

func get_next_diff(volatility: float) -> float:
    var rng := RandomNumberGenerator.new()
    return (rng.randf() * volatility) - (volatility / 2)
