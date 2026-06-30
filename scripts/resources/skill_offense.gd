extends BattleSkill
class_name OffensiveSkill

@export_enum("Strength","Competence","Defense","Agility") var stat_power: String;
@export_enum("Adeneil","Guan","Cytoz","Uracilide","Thymine","Tesseract") var element: String;
@export_enum("Slash","Pierce","Bludgeon") var property: String;

@export var can_deal_critical: bool;
@export var ignore_defense: bool;

func _give_stat_power()->String:
	return stat_power;
	
func _give_property()->String:
	return property;

func _give_element()->String:
	return element;
