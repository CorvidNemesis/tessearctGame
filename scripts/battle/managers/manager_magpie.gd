extends Node

var origin:BattleEntity;
var targeted:BattleEntity;
@onready var cooldown_timer = $"../ActionCoolOff"

func magpie (origin_entity:BattleEntity,target_entity:BattleEntity):
	origin = origin_entity;
	targeted = target_entity;
	var origin_skill = origin_entity.skill_chosen;
	var target_skill = target_entity.skill_chosen;
	origin_skill._reset_skill()
	target_skill._reset_skill()
	var results = await coinflip(origin_skill,target_skill);
	origin_skill._reset_skill()
	target_skill._reset_skill()
	return results;
		
func roll(skill:BattleSkill,actor:BattleEntity):
	var stat_index = skill._get_stat();
	var stat_key = actor.battle_data.source_stat_array[stat_index]
	return actor._magpie_roll(stat_key)

func coinflip(origin_skill:BattleSkill,target_skill:BattleSkill)->Array:
	var result = []
	while (origin_skill.safteyRemaining > 0 and target_skill.safteyRemaining > 0):
		cooldown_timer.start();
		var origin_skill_roll = roll(origin_skill,origin);
		var target_skill_roll = roll(target_skill,targeted);
		await cooldown_timer.timeout;
		if (origin_skill_roll == target_skill_roll):
			origin.roll_visual_instance.animation.play("Tie")
			targeted.roll_visual_instance.animation.play("Tie")
			origin_skill._clashTie();
			target_skill._clashTie();
			print("TIED!")
		elif (origin_skill_roll > target_skill_roll):
			origin.roll_visual_instance.animation.play("Victory")
			target_skill._clashLost()
			targeted.roll_visual_instance.animation.play("Loss")
			result = [origin,targeted]
		else:
			origin.roll_visual_instance.animation.play("Loss")
			origin_skill._clashLost()
			targeted.roll_visual_instance.animation.play("Victory")
			result = [targeted,origin]
		cooldown_timer.start();
		await cooldown_timer.timeout;
	return result;
		
func debug_show_saftey(skill:BattleSkill)->String:
	var coins = skill.name + " ";
	for coin in range(skill.safteyRemaining):
		coins += "●"
	for coin in range(skill.hit_count - skill.safteyRemaining):
		coins += "○"
	coins += " " + str(skill.safteyRemaining) 
	return coins
