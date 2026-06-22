extends Node

@export var inital_state: State
var states: Dictionary = {}
var active_state: State

func _activate() -> void:
	for state in get_children():
		if state is State:
			states[state.name.to_lower()] = state
			state.switch_state.connect(change_state)
	
	if inital_state:
		print("DEBUG: inital_state: " + str(inital_state.name))
		inital_state.enter_state()
		active_state = inital_state;

func change_state(new_state: State)->void:
	if new_state == active_state:
		return
	if active_state:
		active_state.exit_state()
	active_state = new_state
	
	if active_state:
		active_state.enter_state()
	print("DEBUG: SWITCHING TO: " + str(active_state.name.to_lower()))
