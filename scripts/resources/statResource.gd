class_name statsResource
extends Resource

@export var display_name: String;
@export var faceSprite: Texture2D;

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
	"str",
	"cmp",
	"def",
	"agi"
]

@export var stat_dict = {
	"maxHP" : 100,
	"maxMP" : 10,
	"str" : 10,
	"cmp": 10,
	"def": 10,
	"agi": 10,
}

var buff_dict = {
	"str" : 1.0,
	"cmp": 1.0,
	"def": 1.0,
	"agi": 1.0,
}

@export var skillSet: Array[BattleSkill] = []

var property_array = [
	"Slash",
	"Bludgeon",
	"Pierce"
]

var element_array = [
	"Adeneil",
	"Cytoz",
	"Guan",
	"Thyminos",
	"Tesseract"
]

@export var stat_rate_dict = {
	"AttackProperties": {
		"Slash": 1.0,
		"Bludgeon": 1.0,
		"Pierce": 1.0
	} ,
	"Elements" : {
		"Adeneil" : 1.0,
		"Cytoz" : 1.0,
		"Guan" : 1.0,
		"Thyminos": 1.0,
		"Tesseract": 1.0
	}
}

# @export var skillSet = Array[BattleSkill]

var _current_hp: int;
var _current_mp: int;
var stat_current_CF;

func _get_stat_value(statKey:String)->int:
	return roundi(stat_dict[statKey] * buff_dict[statKey])
	
func _get_property_rate(property_index:int)->float:
	var key = property_array[property_index];
	return stat_rate_dict["Property"][key]

func _get_element_rate(property_index:int)->float:
	var key = property_array[property_index];
	return stat_rate_dict["Element"][key]
	
func _get_speed()->int:
	return randi_range(0,roundi(stat_dict["agi"] * buff_dict["agi"]));
