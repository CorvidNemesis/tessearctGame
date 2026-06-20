extends State

var battle_manager:Node2D;
@export var move_state: State;

func enter_state()->void:
	print("///////// DEBUG: PHASE 2 /////////")
	#Not sure
	update_state()
	
func update_state()->void:
	switch_state.emit(move_state)
