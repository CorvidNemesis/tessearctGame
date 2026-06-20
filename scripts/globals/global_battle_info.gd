extends Node2D

const AQ_NAME_KEY_INDEX = 0;
const AQ_SCENE_INDEX = 1;
const AQ_SPEED_INDEX = 2;

var partaking_heroes = [];
var partaking_enemies = [];

## Packages a player as their key, their scene and their speed.
func package(key:String,value:BattleEntity)->Array:
	value._get_battle_data()._init();
	return [key,value,0]

func _queueParticipants(key,value)-> void:
	partaking_heroes.append(package(key,value))
		
func _queueEnemies(key,value)-> void:
	partaking_enemies.append(package(key,value))

signal assign_skill(skill:BattleSkill);
signal targeting(bruh:BattleEntity)
signal next_turn();
