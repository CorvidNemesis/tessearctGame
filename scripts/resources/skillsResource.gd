class_name BattleSkill
extends Resource

enum ElementType {
	ADENEIL = 0,
	GUAN =1,
	CYTOZ = 2,
	THYMINOS = 3,
	TESS=4,
	HEALING = 5
	}
	
enum PropertyType {
	SLASH = 0,
	BLUDGEON =1,
	PIERCE = 2
	}

enum SourceStat {
	STRENGTH = 0,
	COMPETENCE = 1,
	DEFENSE = 2,
	AGILITY = 3
	}


@export var name: String;
@export var element: ElementType;
@export var property: PropertyType;
@export var stat_power: SourceStat;
@export var mp_cost: int;
@export var base_power: int;
@export var description: String;
@export var hit_count: int = 1;
@export var clash_saftey_amount: int;
@export var can_deal_critical: bool;
@export var elemental_icon: Texture2D;

var clashBasePower: int;
var safteyRemaining:int;

func _ready():
	_reset_skill();

func _reset_skill():
	safteyRemaining = hit_count;
	clashBasePower = base_power;

func _clashTie()->void:
	safteyRemaining+=1;

func _clashLost()->void:
	safteyRemaining-=1;
	base_power+=clash_saftey_amount;

func _getDamageAmount(stat:int)-> float:
	return (stat + base_power);

func _getHealingAmount(def:int)->float:
	return (def + base_power);
