class_name statsResource
extends Resource

@export var display_name: String;

var source_stat_array = [
	"Strength",
	"Competence",
	"Defense",
	"Agility"
]

@export var associations_dict = {
	"Firebrand Lineage" : false,
	"Timerender Foundation" : false,
}

@export var stat_dict = {
	"maxHP" : 100,
	"maxMP" : 10,
	"Strength" : 10,
	"Competence": 10,
	"Defense": 10,
	"Agility": 10,
	"Swagger": 5.0,
}

var battle_stat_dict = {
	"maxHP" : 100,
	"maxMP" : 10,
	"Strength" : 10,
	"Competence": 10,
	"Defense": 10,
	"Agility": 10,
	"Swagger": 5.0,
}

var buff_dict = {
	"Strength" : 1.0,
	"Competence": 1.0,
	"Defense": 1.0,
	"Agility": 1.0,
}

@export var skillSet: Array[BattleSkill] = []

@export var resist_dict = {
	"Property": {
		"Slash": 1.0,
		"Bludgeon": 1.0,
		"Pierce": 1.0
	} ,
	"Element": {
		"Adeneil" : 1.0,
		"Cytoz" : 1.0,
		"Guan" : 1.0,
		"Uracilide": 1.0,
		"Thymine": 1.0,
		"Tesseract": 1.0
	}
}

var current_hp: int;
var current_mp: int;
var current_gp: float = 50.0;

func _init() -> void:
	current_hp = stat_dict["maxHP"]
	current_mp = stat_dict["maxMP"]
	for key in stat_dict:
		battle_stat_dict[key] = stat_dict[key]

func _give_stat(statKey:String)->int:
	return roundi(battle_stat_dict[statKey] * buff_dict[statKey])
	
func _get_property_rate(key:String)->float:
	return resist_dict["Property"][key]

func _get_element_rate(key:String)->float:
	return resist_dict["Element"][key]
	
func _get_speed()->int:
	return randi_range(0,roundi(stat_dict["Agility"][1] * buff_dict["Agility"][1]));

func _roll_swag()->bool:
	var chance = randi_range(0,100);
	if chance <= battle_stat_dict["Swagger"]:
		return true;
	else:
		return false;
	
	
