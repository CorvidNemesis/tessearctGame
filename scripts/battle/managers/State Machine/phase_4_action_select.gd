extends State

var battle_manager:Node2D;
@export var loop_state: State
@export var move_state: State

var active_hero: BattleHero;
var ready_to_fight = false;
var current_index = -1;

func enter_state()->void:
	print("DEBUG: PHASE 4 //////////////////////////////")
	battle_manager = _set_battle_manager();
	if current_index == battle_manager.heroes.size()-1:
		print("Checking if can move to next phase")
		if every_one_ready():
			ready_to_fight = true;
			update_state()
		else:
			select_actions();
	else:
		select_actions();

func every_one_ready()->bool:
	for hero:BattleHero in battle_manager.heroes:
		print(hero.battle_data.display_name + " " + str(hero._chosen_an_action()))
		print(hero._chosen_an_action())
		if !hero._chosen_an_action():
			ready_to_fight = false;
			print("Not ready to fight!")
			return false
	print("Ready to fight!")
	return true

## Moves down the action queue
func select_actions()->void:
	current_index = (current_index + 1) % battle_manager.heroes.size();
	print("Current Index: " + str(current_index))
	gl_battle.focused_hero = battle_manager._return_hero(current_index);
	update_state()

func update_state()->void:
	if not ready_to_fight:
		switch_state.emit(loop_state)
	else:
		switch_state.emit(move_state)
