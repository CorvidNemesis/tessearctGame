extends Resource
class_name Skill_Script

const TEMP_WEIGHT = 2;
var damage_outcome

const HP_INDEX = 0
const MP_INDEX = 1
const GP_INDEX = 2

func execute_skill(caster:BattleEntity,active_skill:BattleSkill,target:BattleEntity):
	damage_outcome = [0,0,0];
	print(" PERFORMING SKILL: " + active_skill.name)
	if active_skill is OffensiveSkill:
		var formula = (calculate_caster_impact(caster,active_skill) * TEMP_WEIGHT)
		if caster._roll_swagger() or active_skill.ignore_defense:
			pass
		else:
			formula -= target.battle_data._give_stat("Defense")
		var skill_property = caster.battle_data.resist_dict[active_skill.property]
		formula = calculate_property_resist(formula,skill_property)
		print("Unopposed: " + str(formula))
		match active_skill.element:
			"Adeneil":
				calculate_adeneil(formula,
				target.battle_data._get_element_rate("Adeneil")
				)
			"Guan":
				calculate_guan(
					formula,
				target.battle_data.battle_stat_dict["maxMP"]
				,target.battle_data._get_element_rate("Guan")
				)	
			"Cytoz":
				calculate_cytoz(
					formula,
				target.battle_data.battle_stat_dict["maxMP"]
				,target.battle_data._get_element_rate("Cytoz")
				)	
			"Uracilide":
				calculate_thym_urac(
					formula,
				target.battle_data.battle_stat_dict["maxMP"]
				,target.battle_data._get_element_rate("Uracilide")
				)	
			"Thymine":
				calculate_thym_urac(
					formula,
				target.battle_data.battle_stat_dict["maxMP"]
				,target.battle_data._get_element_rate("Thymine")
				)
			5:
				pass	
	print(target.battle_data.display_name + " takes:")
	print(str(damage_outcome[0]) + " HP Damage!")
	print(str(damage_outcome[1]) + " MP Damage!")
	print(str(damage_outcome[2]) + " GP Damage!")
	return damage_outcome;

func calculate_caster_impact(caster:BattleEntity,active_skill:BattleSkill)->int:
	var stat_key:String;
	stat_key = active_skill._give_stat_power();
	var caster_stat = caster.battle_data._give_stat(stat_key)
	caster_stat += active_skill._give_potency();
	return caster_stat;

func calculate_adeneil(base_value:int,resist:float)->void:
	change_hp(roundi(base_value*resist))
	
func calculate_guan(base_value:int,max_mp:int,resist:float)->void:
	# Normal HP
	# Number based MP
	change_hp(roundi(base_value*resist))
	var mp_damage = (base_value / 2) * resist
	change_mp(roundi(mp_damage))

func calculate_cytoz(base_value:int,max_mp:int,resist:float)->void:
	# Normal HP
	# Percent based MP
	# 999 MP 
	var mp_damage = ((base_value/2/100) * max_mp)
	change_mp(roundi(mp_damage*resist))
	change_gp(roundi((base_value / 10)*resist))

func calculate_thym_urac(base_value:int,max_mp:int,resist:float)->void:
	change_hp(roundi(base_value*resist))
	var mp_damage = ((base_value/100) * max_mp)
	change_mp(roundi(mp_damage*resist))
	change_gp(roundi(base_value / 5))

func calculate_property_resist(damage:int,resist:float)->int:
	return roundi(damage*resist)

func change_hp(amount)->void:
	damage_outcome[HP_INDEX] = amount;

func change_mp(amount)->void:
	damage_outcome[MP_INDEX] = amount;

func change_gp(amount)->void:
	damage_outcome[GP_INDEX] = amount;
