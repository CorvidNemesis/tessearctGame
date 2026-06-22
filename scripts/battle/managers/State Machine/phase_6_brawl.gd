extends State

var battle_manager:Node2D;
@export var move_state: State;

var DEBUG_enemies_act = false;
const CRITICAL = 30;
const SPLASH = 0.25;

func enter_state()->void:
	print("DEBUG: PHASE 6 //////////////////////////////")
	battle_manager = _set_battle_manager();
	await battle_manager.gui.battle_commands._hide_ui();
	brawling();
	update_state()
		
func brawling()->void:
	for entity in battle_manager.heroes:
		print(entity.name + " is attacking with " + entity.skill_chosen.name)
		if entity is BattleHero:
			print(entity.name + " is attacking with " + entity.skill_chosen.name)
			var targetting = calculate_targets(entity.skill_chosen);
			var source_stat = entity.battle_data.stat_dict[entity.skill_chosen._skill_stat_key()];
			calculate_damage(entity.skill_chosen,source_stat[1],targetting);	

func calculate_targets(skill:BattleSkill)->Array:
	var final_array = []
	var full_blast = []
	var halfed = []
	var quartered = []
	var targetting_index = skill.main_target;
	var start = targetting_index;
	var neighbors = []
	full_blast.append(gl_battle.partaking_enemies[start])
	print(skill.target)
	if (skill.target != 0 and skill.target != 4):
		while start >= 0:
			neighbors.append(gl_battle.partaking_enemies[start])
			start -=1;
		halfed.append(neighbors[1])
		if neighbors.size() >2 :
			quartered.append(neighbors[2])
		neighbors.clear()
		start = targetting_index
		while start < gl_battle.partaking_enemies.size():
			neighbors.append(gl_battle.partaking_enemies[start])
			start +=1;
		halfed.append(neighbors[1])
		if neighbors.size() >2 :
			quartered.append(neighbors[2])
	final_array.append(full_blast)
	final_array.append(halfed)
	final_array.append(quartered)
	print(final_array)
	return final_array

func calculate_damage(skill:BattleSkill,stat:int,targets:Array)->void:
	var splash_multiplier = 1.0;
	for target_zone in targets:
		print("Group: " + str(splash_multiplier))
		for target:BattleEntity in target_zone:
			for i in range(skill.hit_count):
				var crit_thresh = randi_range(0,100);
				var damage = roundi(create_damage(skill,stat,target) * splash_multiplier)
				if crit_thresh < CRITICAL:
					print("CRITICAL HIT")
					damage = damage * 3
				print(target.battle_data.display_name + " took " + str(damage))
				target._change_hp(damage)
		splash_multiplier -= SPLASH

func create_damage(skill:BattleSkill,stat:int,target:BattleEntity)->int:	
	var skill_base = skill._getDamageAmount(stat);
	var variance = 1 + randf_range(-0.25,0.25)
	var element_influence = target.battle_data._get_element_rate(skill.element)
	var property_influence = target.battle_data._get_property_rate(skill.property)
	return roundi((((skill_base) * element_influence)*property_influence)*variance);

func update_state()->void:
	switch_state.emit(move_state)
