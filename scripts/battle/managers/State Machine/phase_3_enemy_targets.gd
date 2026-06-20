extends State

@export var move_state: State;

func enter_state()->void:
	print("///////// DEBUG: PHASE 3 /////////")
	# Enemies select their actions, updates the 
	# player gui's alarm to change self mod based on minimum damange value.
	update_state()
	
func update_state()->void:
	switch_state.emit(move_state)
