extends RichTextLabel

var value: float
@export var total_time: float = 4.0
var time: float = 0.0

@export var networth_label: Label
@export var liquid_label: Label

var liquidated = false
var bankrupt = false

signal thing_happened
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%NextButtonResults.visible = false
	thing_happened.connect(_show_additional_stuff)
	if PlayerSaveState.game_states.size() > 0:
		var most_recent_state = PlayerSaveState.game_states[-1]
		value = most_recent_state.trading_profit
		PlayerSaveState.current_money += most_recent_state.trading_profit
		if PlayerSaveState.current_money <= 0:
			liquidated = true
			PlayerSaveState.liquidate_all()
		if PlayerSaveState.current_money <= 0:
			bankrupt = true

func _show_additional_stuff() -> void:
	if liquidated:
		liquid_label.visible = true
		await get_tree().create_timer(1).timeout
	networth_label.visible = true
	networth_label.text = "$" + str(PlayerSaveState.get_networth())
	await get_tree().create_timer(1).timeout
	
	%NextButtonResults.visible = true

func ease_out_sine(t: float) -> float:
	return sin(PI/2 * t)

func _physics_process(delta: float) -> void:
	time += delta
	
	set_label_text(ease_out_sine(min(time/total_time,1)) * value)
	if time/total_time >= 1 and not %NextButtonResults.visible:
		thing_happened.emit()
		
	
func set_label_text(value: float):
	if value < 0:
		text = "-$" + ('%.2f' % -value)
		return
	text = "$" + ('%.2f' % value)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
