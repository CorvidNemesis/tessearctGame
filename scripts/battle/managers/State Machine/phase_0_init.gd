extends State
# Initalizes the battle!

var battle_manager:Node2D;
@export var move_state: State;

func enter_state()->void:
	print("///////// DEBUG: PHASE 0 /////////")
	battle_manager = _set_battle_manager();
	for entity in battle_manager.all_participants:
		entity._ready_for_battle();
	update_state()
		
func update_state()->void:
	switch_state.emit(move_state)
