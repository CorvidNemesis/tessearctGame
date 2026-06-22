extends Node2D

@onready var state_machine = $BattleStateMachine;
@onready var gui = $battleGUI;

var combat_level = 0;
var combat_gauge_value = 0;

var heroes: Array = [];
var current_enemies: Array = [];
var all_participants: Array = [];
var action_queue: Array = [];
var heroes_alive = true;

func _ready() -> void:
	heroes = gl_battle.partaking_heroes;
	current_enemies = gl_battle.partaking_enemies;
	all_participants.append_array(heroes)
	all_participants.append_array(current_enemies)
	state_machine._activate();

func _assign_speed()->void:
	action_queue.clear();
	for entity in all_participants:
		if (entity._is_alive() and entity._is_capable_to_fight()):
			entity[gl_battle.AQ_SPEED_INDEX] = entity._get_speed();
			action_queue.append(entity);
		elif (!entity._is_alive()):
			pass
	action_queue.sort_custom(sort_ascending)

func sort_ascending(a, b):
	if a[gl_battle.AQ_SPEED_INDEX] > b[gl_battle.AQ_SPEED_INDEX]:
		return true
	return false


func _return_heroes()->Array:
	return heroes

func _return_enemies()->Array:
	return current_enemies

func _return_combat_gauge_value()->int:
	return combat_gauge_value;

func _return_hero(index:int)->BattleHero:
	return heroes[index]
