extends State

@export var move_state: State;
var battle_manager:Node2D;

func _ready() -> void:
	gl_battle.next_turn.connect(update_state);

func enter_state()->void:
	print("DEBUG: PHASE 5 //////////////////////////////")
	battle_manager = _set_battle_manager();
	battle_manager.gui._personalize_ui(battle_manager._return_active_hero());

func update_state()->void:
	switch_state.emit(move_state)
