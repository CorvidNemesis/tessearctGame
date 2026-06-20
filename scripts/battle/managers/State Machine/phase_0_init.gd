extends State
# Initalizes the battle!

var battle_manager:Node2D;
@export var move_state: State;

func enter_state()->void:
	print("///////// DEBUG: PHASE 0 /////////")
	battle_manager = _set_battle_manager();
	for entity in battle_manager.all_participants:
		var entity_scene = entity[gl_battle.AQ_SCENE_INDEX]
		entity_scene._ready_for_battle();
	update_state()
		
func update_state()->void:
	switch_state.emit(move_state)
