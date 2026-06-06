class_name BattleEntity
extends Node2D

@export var battle_data: statsResource;
@export var battle_text: quotesResource;
@export var defensive_skill: BattleSkill;

@export var entity_sprite_sheet: AnimatedSprite2D;
@export var animation_effects: AnimationPlayer;
@export var dialouge: Label;
# @export var rolling_visual: PackedScene;

var skill_chosen:BattleSkill;
var targets = [];
var is_defending: bool = false;
var living_status = true;
var mobility_status = true;

func _get_battle_data():
	return battle_data

func _battle_phase_setup()->void:
	
	targets = [];
	is_defending = false;

func _isAlive()->bool:
	if (battle_data._current_hp <= 0):
		living_status = false;
	return living_status;

func _is_capable_to_fight()->bool:
	return true

func _is_capable_to_target()->bool:
	return true

func _execute_skill()->void:
	for hit in range(skill_chosen.hit_count):
		var stat_choice = battle_data.source_stat_array[skill_chosen.stat_power];
		var damage = skill_chosen._getDamageAmount(stat_choice);
		for targeting in targets:
			targets._change_hp(damage)
			print(targets._current_hp)

func _change_hp(amount:int)->void: 
	battle_data._current_hp -= amount;

func _get_speed()->int:
	return battle_data._get_speed();

func helper_battle_getBasePower()->int:
	return skill_chosen.clashBasePower;

func _clash_marble_roll(statKey:String)->int:
	var finalValue = helper_battle_getBasePower() + battle_data._get_stat_value(statKey);
	return randi_range(helper_battle_getBasePower(),finalValue);
	# TODO: Remmeber counter and defense dice! Make em unique

func _helper_clear_skill()->void:
	self.skill_chosen = null;
