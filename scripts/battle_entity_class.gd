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

func _get_battle_data():
	return battle_data

func _battle_phase_setup()->void:
	targets = [];
	is_defending = false;

func _is_battle_ready()-> bool:
	if (((self.skill_chosen != null) and !self.targets.is_empty()) or is_defending):
		return true
	return false

func _execute_skill()->void:
	for hit in range(skill_chosen.hit_count):
		var stat_choice = battle_data.source_stat_array[skill_chosen.stat_power];
		var damage = skill_chosen._getDamageAmount(stat_choice);
		for targeting in targets:
			targets._change_hp(damage)
			print(targets.stat_current_hp)

func _change_hp(amount:int)->void: 
	battle_data.stat_current_HP -= amount;

func _helper_clear_skill()->void:
	self.skill_chosen = null;
