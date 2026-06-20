extends State

var battle_manager:Node2D;
@export var move_state: State;

func enter_state()->void:
	battle_manager = _set_battle_manager();
	for entity in battle_manager.all_participants:
		var entity_scene:BattleEntity = entity[gl_battle.AQ_SCENE_INDEX]
		entity_scene.skill_chosen = null
		entity_scene.selected_skill = false
		if !entity_scene._is_alive():
			#if enemy is dead, removes them
			pass
	update_state()
		
func update_state()->void:
	switch_state.emit(move_state)
