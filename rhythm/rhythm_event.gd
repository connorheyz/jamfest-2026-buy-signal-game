extends Resource
class_name RhythmEvent

var start_ticks: int
var critical_tick: int
var duration_ticks: int
var pre_cue: Cue
var post_cue: Cue
var type: bool ## true buy, false sell

func _init(p_start_ticks: int, p_critical_tick: int, p_duration_ticks: int, p_pre_cue: Cue, p_post_cue: Cue, p_type: bool):
	start_ticks = p_start_ticks
	critical_tick = p_critical_tick
	duration_ticks = p_duration_ticks
	pre_cue = p_pre_cue
	post_cue = p_post_cue
	type = p_type
