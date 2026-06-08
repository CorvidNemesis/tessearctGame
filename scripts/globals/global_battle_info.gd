extends Node2D

const AQ_NAME_KEY_INDEX = 0;
const AQ_SCENE_INDEX = 1;
const AQ_SPEED_INDEX = 2;

var partaking_heroes = [];
var partaking_enemies = [];

signal battle_signal_open_actions();
signal battle_signal_close_actions();
signal battle_signal_prepareSkillset();
signal battle_signal_makeSkillCard();
signal battle_signal_readyCheck();
signal battle_signal_ui_troop_hp();
signal battle_signal_ui_hero_hp(hero:BattlePlayer);

signal battle_signal_phase_start_turn();

func package(key:String,value:BattleEntity)->Array:
	return [key,value,0]

func _queueParticipants(key,value)-> void:
	partaking_heroes.append(package(key,value))
		
func _queueEnemies(key,value)-> void:
	print("Step 2.2: Queue enemies into scene")
	partaking_enemies.append(package(key,value))

var currently_selected_hero: BattlePlayer;

var battles_can_begin = false;
#
#func _allow_battle_start()->void:
	#if (battles_can_begin):
		#$BeginButton.disabled = false;
	#else:
		#$BeginButton.disabled = true;
