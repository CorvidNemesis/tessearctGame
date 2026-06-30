extends State

var battle_manager:Node2D;
@export var move_state: State;

func enter_state()->void:
	print("DEBUG: PHASE 8 //////////////////////////////")
	battle_manager = _set_battle_manager();
	for entity in battle_manager.heroes:
		entity.skill_chosen = null
		if !entity._is_alive():
			#if enemy is dead, removes them
			pass
	update_state()
		
func update_state()->void:
	switch_state.emit(move_state)
