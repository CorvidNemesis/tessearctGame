class_name BattleSkill
extends Resource

enum TARGETING {
	SINGLE,
	TRIPLE_SPLASH,
	TRIPLE_ALL,
	FIVE_SPLASH,
	MASS_SUMMATION,
	RANDOM,
}

@export var name: String;
@export var target: TARGETING;
@export var mp_cost: int;
@export var base_power: int;
@export var description: String;
@export var elemental_icon: Texture2D;

var main_target:int

func _getHealingAmount(def:int)->float:
	return (def + base_power);
