extends State

var battle_manager:Node2D;
@export var move_state: State;

var DEBUG_enemies_act = false;
const CRITICAL = 30;
const SPLASH = 0.25;

func enter_state()->void:
	print("DEBUG: PHASE 7 //////////////////////////////")
	battle_manager = _set_battle_manager();
	await battle_manager.gui.battle_commands._hide_ui();
	brawling();
		
func brawling()->void:
	print(battle_manager.action_queue)
	for action in battle_manager.action_queue:
		await action.call();
		await get_tree().create_timer(4).timeout

func update_state()->void:
	switch_state.emit(move_state)
