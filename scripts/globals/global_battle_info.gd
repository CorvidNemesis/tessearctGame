extends Node2D

var partaking_heroes = [];
var partaking_enemies = [];

signal assign_skill(skill:BattleSkill);
signal targeting(index:int)
signal next_turn();
## Packages a player as their key, their scene and their speed.
func package(key:String,value:BattleEntity)->Array:
	value._get_battle_data()._init();
	return [key,value,0]

func _queueParticipants(key,value)-> void:
	partaking_heroes.append(package(key,value))
		
func _queueEnemies(key,value)-> void:
	partaking_enemies.append(package(key,value))
