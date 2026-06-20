extends BattleSkill
class_name OffensiveSkill

@export_enum("Strength","Competence","Defense","Agility") var stat_power: String;
@export_enum("Adeneil","Guan","Cytoz","Thymin","Tesseract") var element: String;
@export_enum("Slash","Pierce","Bludgeon") var property: String;
@export var hit_count: int = 1;
@export var can_deal_critical: bool;

func _skill_stat_key()->String:
	return stat_power;

func _getDamageAmount(stat:int)-> float:
	return (stat + base_power);
