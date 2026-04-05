extends Node2D
class_name RhythmScene

signal enqueue_cue(cue: Cue) 

var rhythm: Rhythm

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rhythm = Rhythm.new()
	rhythm.enqueue_cue.connect(_on_enqueue_cue)
	rhythm.rhythm_happening.connect(_on_rhythm_happening)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func do_tick() -> void:
	rhythm.do_tick()

func _on_enqueue_cue(cue: Cue):
	enqueue_cue.emit(cue)

func bought_or_sold():
	rhythm.bought_or_sold()
func _on_rhythm_happening(start_ticks: int) -> void:
	
	$CuePlayer.stream = load("res://test/buy.mp3")
	$CuePlayer.play()
