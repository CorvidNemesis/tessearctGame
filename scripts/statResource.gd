class_name statsResource
extends Resource

@export var display_name: String;
@export var faceSprite: Texture2D;

@export var stat_dict = {
	"maxHP" : 100,
	"maxMP" : 10,
	"str" : 10,
	"cmp": 10,
	"def": 10,
	"agi": 10,
}

@export var stat_rate_dict = {
	"AttackProperties": {
		"Slash": 1.0,
		"Bludgeon": 1.0,
		"Pierce": 1.0
	} ,
	"Elements" : {
		"Light" : 1.0,
		"Fire" : 1.0,
		"Water" : 1.0,
		"Volt": 1.0,
		"Wind": 1.0,
		"Ground": 1.0,
		"Toxic": 1.0,
		"Tesseract": 1.0
	}
}

# @export var skillSet = Array[BattleSkill]

var stat_current_HP: int = stat_dict["maxHP"];
var stat_current_MP: int = stat_dict["maxMP"];
var stat_current_CF: int = 50;

var living = true;

func _LifeCheck()->void:
	if (stat_current_HP <= 0):
		!living;
		
