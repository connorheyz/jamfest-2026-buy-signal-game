extends Node2D

signal button_queue_up_pressed(type: Stock.FunctionType, p_volatility: float, start_ticks: int, duration_ticks: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	button_queue_up_pressed.emit(int(%TypeLineEdit.text), float(%VolatilityLineEdit.text), int(%StartLineEdit.text), int(%DurationLineEdit.text))
	pass
