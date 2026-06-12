class_name battleEnemy;
extends BattleEntity

#TODO: Make actual enemy targeting bro
func _enemy_choose_skill_simple()->void:
	skill_chosen = _get_battle_data().skillSet[0]
	print(skill_chosen)
	var targetList = gl_battle.partaking_heroes;
	var randomNumber = randi_range(0,targetList.size()-1)
	targets.append(targetList[randomNumber])
