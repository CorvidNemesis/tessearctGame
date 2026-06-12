extends Node

func _execute_damage_skill(user: BattleEntity,skill:BattleSkill):
	user._action_start();
	print(user.name + " uses " + skill.name + "!")
	await get_tree().create_timer(1).timeout
	for targeting in user.targets:
		print(targeting[1])
		for hit in range(skill.hit_count):
			print(hit)
			var stat_choice = skill._get_stat();
			var stat = user.battle_data.stat_dict[user.battle_data.source_stat_array[stat_choice]]
			var damage = skill._getDamageAmount(stat);
			damage = property_shift(skill,targeting[gl_battle.AQ_SCENE_INDEX],damage)
			damage = element_shift(skill,targeting[gl_battle.AQ_SCENE_INDEX],damage)
			var variation = randf_range(0.75,1.25)
			damage = damage * variation
			damage= roundi(damage)
			targeting[1].damage_number.label.text = str(damage);
			targeting[1].damage_number.effector.play("Damage");
			targeting[1]._change_hp(damage)
			print(targeting[1].name + " took " + str(damage))
			gl_battle.emit_signal("battle_signal_ui_troop_hp",user,damage)
			await get_tree().create_timer(1).timeout
func element_shift(skill:BattleSkill,target:BattleEntity,damage)->float:
	var skill_element = target.battle_data.element_array[skill.element];
	return target.battle_data.stat_rate_dict["Elements"][skill_element] * damage;

func property_shift(skill:BattleSkill,target:BattleEntity,damage)->float:
	var skill_property = target.battle_data.property_array[skill.property];
	return target.battle_data.stat_rate_dict["AttackProperties"][skill_property] * damage;
