extends State

@export var move_state: State;

func enter_state()->void:
	print("///////// DEBUG: PHASE 1 /////////")
	# Checks if the party gauge is 100, if so then it'll bring up the rouge cards.
	update_state()
	
func update_state()->void:
	switch_state.emit(move_state)
