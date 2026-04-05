extends Resource
class_name Rhythm

signal enqueue_cue(cue: Cue)
signal rhythm_happening(start_ticks: int)

var rhythm_queue: Array[RhythmEvent]
var rng: RandomNumberGenerator
var dont_change: int
var next_critical: int
var thing_to_look_for: bool ## true buy, false sell
var action_taken: bool
var is_critical_now: bool

func _init() -> void:
	rhythm_queue = []
	rng = RandomNumberGenerator.new()
	dont_change = 0
	next_critical = 0
	action_taken = false
	is_critical_now = false

func do_tick() -> void:
	if len(rhythm_queue) > 0:
		print_debug("Rhythm queue ", rhythm_queue) 
		for rhythm_index in range(len(rhythm_queue) - 1, -1, -1):
			var rhythm_event: RhythmEvent = rhythm_queue[rhythm_index]
			if rhythm_event.start_ticks == 0:
				print_debug("Applying rhythm event")
				dont_change = rhythm_event.duration_ticks
				next_critical = rhythm_event.critical_tick
				rhythm_queue.remove_at(0)
				enqueue_cue.emit(rhythm_event.pre_cue)
				enqueue_cue.emit(rhythm_event.post_cue)
				thing_to_look_for = true
				rhythm_happening.emit(rhythm_event.critical_tick)
			else: 
				rhythm_event.start_ticks -= 1 

	if next_critical > 1:
		next_critical -= 1
		if next_critical == 1:
			is_critical_now = true
			print_debug("Critical tick")            
			pass
		return

	if is_critical_now:
		if next_critical == 1:
			next_critical -= 1
			return
		if action_taken:
			print_debug("Rhythm correct")
		else:
			print_debug("Rhythm missed")
		is_critical_now = false

	if dont_change > 1:
		dont_change -= 1
		if dont_change == 1:
			## reset whatever
			pass
		return        

	if rng.randf() < 0.2 and len(rhythm_queue) == 0:
		rhythm_queue.append(
			RhythmEvent.new(
				4, 
				6, 
				7, 
				Cue.new(
					Stock.FunctionType.LINEAR,
					-50,
					3,
					3,
				),
				Cue.new(
					Stock.FunctionType.LINEAR,
					100,
					11,
					7,                                                            
				),
				true
			)
		)

func bought_or_sold():
	if is_critical_now:
		action_taken = true
				
