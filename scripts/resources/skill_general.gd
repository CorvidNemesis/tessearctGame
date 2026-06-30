class_name BattleSkill
extends Resource

enum SKILL_TARGETING {
	SELF,
	SINGLE,
	TRIPLE_SPLASH,
	TRIPLE_ALL,
	FIVE_SPLASH,
	MASS_SUMMATION,
}

enum SKILL_GROUP {
	ENEMIES,
	PARTY,
}

@export_category("Display")
@export var name: String;
@export var description: String;
@export var elemental_icon: Texture2D;

@export_category("Combat")


@export var minimum_potency: int = 1;
@export var maxiumum_potency: int = 50;
@export var aimed_at: BattleSkill.SKILL_GROUP;
@export var target: BattleSkill.SKILL_TARGETING;
@export var mp_cost: int;
@export var execution_script: Skill_Script;

func _give_potency():
	return randi_range(minimum_potency,maxiumum_potency)

@export var hit_debuff = {
	"Strength" : 1.0,
	"Competence": 0.0,
	"Defense": 0.0,
	"Agility": 0.0,
}
@export var hit_count: int = 1;
var main_target:int;
