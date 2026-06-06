extends Node2D

var partaking_char = {};
var partaking_enemies = [];


signal battle_signal_openActions();
signal battle_signal_prepareSkillset();
signal battle_signal_makeSkillCard();
signal battle_signal_readyCheck();

signal battle_signal_phase_start_turn();

func _queueParticipants(key,value)-> void:
	print("Step 2.1: Queue player characters into scene")
	partaking_char[key] = value
		
func _queueEnemies(enemy:battleEnemy)-> void:
	print("Step 2.2: Queue enemies into scene")
	partaking_enemies.append(enemy);	

var currently_selected_hero: BattlePlayer;

var battles_can_begin = false;
#
#func _allow_battle_start()->void:
	#if (battles_can_begin):
		#$BeginButton.disabled = false;
	#else:
		#$BeginButton.disabled = true;
