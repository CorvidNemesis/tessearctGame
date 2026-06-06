class_name battleEnemy;
extends BattleEntity


#TODO: Make actual enemy targeting bro
func _enemy_choose_skill_simple()->void:
	skill_chosen = _get_battle_data().skillSet[0]
	var targetList = global_battle_information.partaking_char.keys();
	var randomNumber = randi_range(0,targetList.size()-1)
	targets.append(global_battle_information.partaking_char[targetList[randomNumber]])
	print('Sussy Baka!')
	print(skill_chosen)
	print(targets)
