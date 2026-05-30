class_name battleEnemy;
extends Node2D

@export var battleStats: statsResource;
@export var battleSkills = [BattleSkill];

var skillChosen:BattleSkill;

func _getStats():
	return battleStats
