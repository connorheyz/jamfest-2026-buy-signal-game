extends RichTextLabel

var value: float
@export var total_time: float = 4.0
var time: float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%NextButtonResults.visible = false
	if PlayerSaveState.game_states.size() > 0:
		var most_recent_state = PlayerSaveState.game_states[-1]
		value = most_recent_state.trading_profit

func ease_out_sine(t: float) -> float:
	return sin(PI/2 * t)

func _physics_process(delta: float) -> void:
	time += delta
	
	set_label_text(ease_out_sine(min(time/total_time,1)) * value)
	if time/total_time >= 1 and not %NextButtonResults.visible:
		%NextButtonResults.visible = true
	
func set_label_text(value: float):
	if value < 0:
		text = "-$" + ('%.2f' % -value)
		return
	text = "$" + ('%.2f' % value)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
