class_name battleEnemy;
extends Node2D

@export var battle_data: statsResource;

var skill_chosen:BattleSkill;
var target:BattlePlayer;

func _getStats():
	return battle_data

func _ready() -> void:
	_enemy_choose_skill_simple();

#TODO: Make actual enemy targeting bro
func _enemy_choose_skill_simple()->void:
	skill_chosen = _getStats().skillSet[0]
	
	var targetList = global_battle_information.partaking_char.keys();
	var randomNumber = randi_range(0,targetList.size()-1)
	target = global_battle_information.partaking_char[targetList[randomNumber]]
	print('Sussy Baka!')
	print(skill_chosen)
	print(target)

func helper_battle_getBasePower()->int:
	return skill_chosen.basePower;

func _clash_marble_roll(statKey:String)->int:
	var finalValue = helper_battle_getBasePower() + battle_data._get_stat_value(statKey);
	return randi_range(0,finalValue);

func execute_skill()->void:
	for hit in range(skill_chosen.hit_count):
		var stat_choice = battle_data.source_stat_array[skill_chosen.stat_power]
		var damage = skill_chosen._getDamageAmount(stat_choice);
		for targeting in target:
			target._change_hp(damage)

func _change_hp(amount:int)->void: 
	battle_data.stat_current_HP -= amount;
