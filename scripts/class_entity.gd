class_name BattleEntity
extends Node2D

@export var battle_data: statsResource;
@export var face: AnimatedSprite2D;
@export var animation_effects: AnimationPlayer;

var key_name:String;

var skill_chosen:BattleSkill;
var targets = [];
var is_defending: bool = false;
var living_status = true;
var mobility_status = true;
var selected_skill = false;

func _ready_for_battle():
	_reset_entity()

func _get_battle_data():
	return battle_data

func _reset_entity()->void:
	targets = [];
	skill_chosen = null;
	is_defending = false;

func _is_alive()->bool:
	if (self.battle_data.current_hp <= 0):
		living_status = false;
	else:
		living_status = true;
	return living_status;

func _change_hp(amount:int)->void:
	var _damage = amount - self.battle_data._skill_stat_key_value("Defense")
	self.battle_data.current_hp -= _damage;

func _get_speed()->int:
	return battle_data._get_speed();
