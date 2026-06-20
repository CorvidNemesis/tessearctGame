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
	select_actions();

func every_one_ready()->bool:
	for hero in gl_battle.partaking_heroes:
		if hero.selected_skill == false:
			ready_to_fight = false;
			return false
	ready_to_fight = true;
	return true

## Moves down the action queue
func select_actions()->void:
	current_index = (current_index + 1) % battle_manager.heroes.size();
	print("Current Index: " + str(current_index))
	if current_index == battle_manager.heroes.size()-1:
		if every_one_ready():
			update_state()
	active_hero = battle_manager._return_hero(current_index);
	print(active_hero)
	print(active_hero.name + "'s turn!")
	print("Is this guy ready?" + str(active_hero.skill_chosen))
	battle_manager._set_active_hero(active_hero);
	update_state()

func update_state()->void:
	if not ready_to_fight:
		switch_state.emit(loop_state)
	else:
		switch_state.emit(move_state)
