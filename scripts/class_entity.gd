class_name BattleEntity
extends Node2D

@export var battle_data: statsResource;
@export var animation_effects: AnimationPlayer;

signal hp_update

var key_name:String;
var id_number:int;

var skill_chosen:BattleSkill = null;
var targets = [];
var is_defending: bool = false;
var living_status = true;
var mobility_status = true;

#region Battle Data

func _get_battle_data():
	return battle_data
	
func _get_stat_value(key:String):
	return battle_data.stat_dict[key][1];	
#endregion

func _ready_for_battle():
	_reset_entity()

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
	self.battle_data.current_hp -= amount;
	emit_signal("hp_update")

func _get_speed()->int:
	return battle_data._get_speed();

func _chosen_an_action()->bool:
	if self.skill_chosen or is_defending:
		return true;
	else:
		return false;
		
