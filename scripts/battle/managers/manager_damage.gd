extends Node

func _execute_damage_skill(user: BattleEntity,skill:BattleSkill):
	for hit in range(skill.hit_count):
		var stat_choice = skill._get_stat();
		var stat = user.battle_data.stat_dict[user.battle_data.source_stat_array[stat_choice]]
		var damage = skill._getDamageAmount(stat);
		for targeting in user.targets:
			damage = property_shift(skill,targeting[gl_battle.AQ_SCENE_INDEX],damage)
			damage = element_shift(skill,targeting[gl_battle.AQ_SCENE_INDEX],damage)
			targeting[1]._change_hp(roundi(damage))
			gl_battle.emit_signal("battle_signal_ui_troop_hp",user,damage)
			
func element_shift(skill:BattleSkill,target:BattleEntity,damage)->float:
	var skill_element = target.battle_data.element_array[skill.element];
	return target.battle_data.stat_rate_dict["Elements"][skill_element] * damage;

func property_shift(skill:BattleSkill,target:BattleEntity,damage)->float:
	var skill_property = target.battle_data.property_array[skill.property];
	return target.battle_data.stat_rate_dict["AttackProperties"][skill_property] * damage;
