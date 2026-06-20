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
	await brawling();
		
func brawling()->void:
	for entity in battle_manager.all_participants:
		var acting:BattleEntity = entity[gl_battle.AQ_SCENE_INDEX];
		if acting is BattleAce:
			var targetting = calculate_targets(acting.skill_chosen);
			var source_stat = acting.battle_data.stat_dict[acting.skill_chosen._skill_stat_key()][1];
			calculate_damage(acting.skill_chosen,source_stat,targetting);	
			print()

func calculate_targets(skill:BattleSkill)->Array:
	var final_array = []
	var full_blast = []
	var halfed = []
	var quartered = []
	var targetting_index = skill.main_target;
	var start = targetting_index;
	var neighbors = []
	full_blast.append(gl_battle.partaking_enemies[start][gl_battle.AQ_SCENE_INDEX])
	print(skill.target)
	if skill.target != 0 or skill.target != 4:
		while start >= 0:
			neighbors.append(gl_battle.partaking_enemies[start][gl_battle.AQ_SCENE_INDEX])
			start -=1;
		halfed.append(neighbors[1])
		if neighbors.size() >2 :
			quartered.append(neighbors[2])
		neighbors.clear()
		start = targetting_index
		while start < gl_battle.partaking_enemies.size():
			neighbors.append(gl_battle.partaking_enemies[start][gl_battle.AQ_SCENE_INDEX])
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
	update_state()

func create_damage(skill:BattleSkill,stat:int,target:BattleEntity)->int:	
	var skill_base = skill._getDamageAmount(stat);
	var variance = 1 + randf_range(-0.25,0.25)
	var element_influence = target.battle_data._get_element_rate(skill.element)
	var property_influence = target.battle_data._get_property_rate(skill.property)
	return roundi((((skill_base) * element_influence)*property_influence)*variance);

func update_state()->void:
	switch_state.emit(move_state)
