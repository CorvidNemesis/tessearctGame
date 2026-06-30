extends State

@export var move_state: State;
var battle_manager:Node2D;
var group: BattleSkill.SKILL_GROUP;

func _ready() -> void:
	battle_manager = _set_battle_manager();


func enter_state()->void:
	gl_battle.next_turn.connect(update_state,CONNECT_ONE_SHOT)
	group = gl_battle.focused_hero.skill_chosen.aimed_at;
	match group:
		BattleSkill.SKILL_GROUP.ENEMIES:
			for enemy:BattleFiend in battle_manager.current_wave:
				enemy.selection.disabled = false;
		BattleSkill.SKILL_GROUP.PARTY:
			battle_manager.gui._targeting_on(); 

func update_state()->void:
	match group:
		BattleSkill.SKILL_GROUP.ENEMIES:
			for enemy:BattleFiend in battle_manager.current_wave:
				enemy.selection.disabled = true;
		BattleSkill.SKILL_GROUP.PARTY:
			battle_manager.gui._targeting_off();
	switch_state.emit(move_state)
