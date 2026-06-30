extends Node

const MAX_CENTER = 2
const MIN_ONE_LEFT_NEIGHBOR = 0;
var MIN_ONE_RIGHT_NEIGHBOR;
var MIN_TWO_RIGHT_NEIGHBORS;
const MIN_TWO_LEFT_NEIGHBORS = 1;
const CRITICAL = 30;
const SPLASH = 0.25;
const DEFEND = 0.5;

var battle_manager:Node2D;

func _ready() -> void:
	battle_manager = get_parent()

func group_targets(aimed_index:int,current_target:BattleSkill.SKILL_TARGETING,current_grouping: BattleSkill.SKILL_GROUP)->Array:
	match current_grouping:
		BattleSkill.SKILL_GROUP.ENEMIES:
			MIN_ONE_RIGHT_NEIGHBOR = battle_manager.current_wave.size()-1;
			MIN_TWO_RIGHT_NEIGHBORS = battle_manager.current_wave.size()-2;
		BattleSkill.SKILL_GROUP.PARTY:
			MIN_ONE_RIGHT_NEIGHBOR = battle_manager.heroes.size()-1;
			MIN_TWO_RIGHT_NEIGHBORS = battle_manager.heroes.size()-2;

	var final_array = []
	var full_blast = []
	var halfed = []
	var quartered = []
	
	match current_target:
		BattleSkill.SKILL_TARGETING.SINGLE:
			full_blast.append(gl_battle.partaking_enemies[aimed_index])
		BattleSkill.SKILL_TARGETING.TRIPLE_SPLASH:
			full_blast.append(gl_battle.partaking_enemies[aimed_index])
			if aimed_index > MIN_ONE_LEFT_NEIGHBOR:
				halfed.append(gl_battle.partaking_enemies[aimed_index-1])
			if aimed_index < MIN_ONE_RIGHT_NEIGHBOR:
				halfed.append(gl_battle.partaking_enemies[aimed_index+1])
		BattleSkill.SKILL_TARGETING.TRIPLE_ALL:
			full_blast.append(gl_battle.partaking_enemies[aimed_index])
			if aimed_index > MIN_ONE_LEFT_NEIGHBOR:
				full_blast.append(gl_battle.partaking_enemies[aimed_index-1])
			if aimed_index < MIN_ONE_RIGHT_NEIGHBOR:
				full_blast.append(gl_battle.partaking_enemies[aimed_index+1])
		BattleSkill.SKILL_TARGETING.FIVE_SPLASH:
			full_blast.append(gl_battle.partaking_enemies[aimed_index])
			if aimed_index > MIN_TWO_LEFT_NEIGHBORS:
				halfed.append(gl_battle.partaking_enemies[aimed_index-1])
				quartered.append(gl_battle.partaking_enemies[aimed_index-2])
			elif aimed_index > MIN_ONE_LEFT_NEIGHBOR:
				halfed.append(gl_battle.partaking_enemies[aimed_index-1])

			if aimed_index < MIN_TWO_RIGHT_NEIGHBORS:
				halfed.append(gl_battle.partaking_enemies[aimed_index+1])
				quartered.append(gl_battle.partaking_enemies[aimed_index+2])
			elif aimed_index< MIN_ONE_RIGHT_NEIGHBOR:
				halfed.append(gl_battle.partaking_enemies[aimed_index+1])
		BattleSkill.SKILL_TARGETING.MASS_SUMMATION:
			final_array.append_array(gl_battle.partaking_enemies[aimed_index+1])
	final_array.append(full_blast)
	final_array.append(halfed)
	final_array.append(quartered)
	return final_array
	
func calculate_damage(caster:BattleEntity,skill:BattleSkill,target_groups:Array)->void:
	var splash_multiplier = 1.0;
	for group in target_groups:
		for enemy in group:
			for hit in range(skill.hit_count):
				print(" HIT " + str(hit) + " / " + str(skill.hit_count))
				skill.execution_script.execute_skill(caster,skill,enemy);
	
