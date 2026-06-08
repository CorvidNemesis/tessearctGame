class_name BattleEntity
extends Node2D

@export var battle_data: statsResource;
@export var battle_text: quotesResource;
@export var defensive_skill: BattleSkill;

@export var entity_sprite_sheet: AnimatedSprite2D;
@export var animation_effects: AnimationPlayer;
@export var dialouge: Label;
@export var roll_zone: Control;
@export var rolling_visual: PackedScene;

var skill_chosen:BattleSkill;
var targets = [];
var is_defending: bool = false;
var is_clashing: bool = true;
var living_status = true;
var mobility_status = true;
var roll_visual_instance;

var home_position;

#region Helper Functions
func _get_battle_data():
	return battle_data
#endregion

#region Battle Begin
func _reset_entity()->void:
	battle_data._current_hp = battle_data.stat_dict["maxHP"];
	battle_data._current_mp = battle_data.stat_dict["maxMP"];
	targets = [];
	is_defending = false;
	is_clashing = true;
#endregion

#region Magpie Functions
func _magpie_skill_base()->int:
	return skill_chosen.clashBasePower;
	
func _magpie_roll(statKey:String)->int:
	var finalValue = _magpie_skill_base() + battle_data._get_stat_value(statKey);
	var result = randi_range(_magpie_skill_base(),finalValue);
	for roller in roll_zone.get_children():
		roller.queue_free()
	roll_visual_instance = rolling_visual.instantiate();
	roll_zone.add_child(roll_visual_instance);
	roll_visual_instance._store(result);
	roll_visual_instance.timer_trigger();
	roll_visual_instance._remaining(skill_chosen);
	return result;

func _magpie_lose()->void:
	pass

func _magpie_tie()->void:
	pass

func _magpie_win()->void:
	pass


#endregion

func _assign_home(home:Vector2)->void:
	home_position=home;


func _is_alive()->bool:
	if (self.battle_data._current_hp <= 0):
		living_status = false;
	else:
		living_status = true;
	return living_status;

func _is_capable_to_fight()->bool:
	return true

func _is_capable_to_target()->bool:
	return true

func _change_hp(amount:int)->void:
	var _damage = amount - self.battle_data._get_stat_value("def")
	self.battle_data._current_hp -= _damage;

func _get_speed()->int:
	return battle_data._get_speed();
