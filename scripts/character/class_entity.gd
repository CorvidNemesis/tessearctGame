class_name BattleEntity
extends Node2D

@export var battle_data: statsResource;
@export var animation_effects: AnimationPlayer;

signal hp_update

var key_name:String;
var id_number:int;
var index = 0;


var skill_chosen:BattleSkill = null;
var target_index: int;
var is_defending: bool = false;
var living_status = true;
var mobility_status = true;

#region Battle Data

func _get_battle_data():
	return battle_data
	
func _get_stat_value(key:String):
	return battle_data.battle_stat_dict[key];	
#endregion

#region Getters

func _get_speed()->int:
	return battle_data._get_speed();

#endregion

#region Setters
func _change_hp(amount:int)->void:
	self.battle_data.current_hp -= amount;
	animation_effects.play("battle_animations/damage")
	await animation_effects.animation_finished
	emit_signal("hp_update")
	
func _set_skill(skill:BattleSkill)->void:
	self.skill_chosen = skill;

func _set_skill_target(targets_index:int)->void:
	self.skill_chosen.main_target = targets_index;
#endregion

#region Checkers

func _is_alive()->bool:
	if (self.battle_data.current_hp <= 0):
		living_status = false;
	else:
		living_status = true;
	return living_status;

func _ready_for_battle():
	_reset_entity()	

#endregion

func _reset_entity()->void:
	skill_chosen = null;
	is_defending = false;


func _chosen_an_action()->bool:
	if self.skill_chosen or is_defending:
		return true;
	else:
		return false;
