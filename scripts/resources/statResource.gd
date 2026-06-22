class_name statsResource
extends Resource

@export var display_name: String;

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
	"maxHP" : [100,100],
	"maxMP" : [10,10],
	"Strength" : [10,10],
	"Competence": [10,10],
	"Defense": [10,10],
	"Agility": [10,10],
}

var buff_dict = {
	"Strength" : 1.0,
	"Competence": 1.0,
	"Defense": 1.0,
	"Agility": 1.0,
}

@export var skillSet: Array[BattleSkill] = []

@export var stat_rate_dict = {
	"Property": {
		"Slash": 1.0,
		"Bludgeon": 1.0,
		"Pierce": 1.0
	} ,
	"Element": {
		"Adeneil" : 1.0,
		"Cytoz" : 1.0,
		"Guan" : 1.0,
		"Thyminos": 1.0,
		"Tesseract": 1.0
	}
}

var current_hp: int;
var current_mp: int;

func _init() -> void:
	current_hp = stat_dict["maxHP"][1]
	current_mp = stat_dict["maxMP"][1]

func _skill_stat_key_value(statKey:String)->int:
	return roundi(stat_dict[statKey][1] * buff_dict[statKey])
	
func _get_property_rate(key:String)->float:
	return stat_rate_dict["Property"][key]

func _get_element_rate(key:String)->float:
	return stat_rate_dict["Element"][key]
	
func _get_speed()->int:
	return randi_range(0,roundi(stat_dict["Agility"][1] * buff_dict["Agility"][1]));
