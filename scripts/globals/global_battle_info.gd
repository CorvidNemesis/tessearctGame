extends Node2D

const aqKey = 0;
const aqScene = 1;
const ACTION_QUEUE_SPEED = 2;

var partaking_heroes = [];
var partaking_enemies = [];



signal battle_signal_openActions();
signal battle_signal_prepareSkillset();
signal battle_signal_makeSkillCard();
signal battle_signal_readyCheck();

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
