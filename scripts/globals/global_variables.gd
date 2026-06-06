extends Node2D
var PATH = "res://scenes/characterScenes/"

var scene_Fenik: PackedScene = preload("res://scenes/characterScenes/Scene_Battle_Char_Fenik.tscn")
#var scene_Virus: PackedScene = preload("res://scenes/characterScenes/Scene_Battle_Char_Virus.tscn")
#var scene_Comet: PackedScene = preload("res://scenes/characterScenes/Scene_Battle_Char_Comet.tscn")
#var scene_Flora: PackedScene = preload("res://scenes/characterScenes/Scene_Battle_Char_Flora.tscn")
var scene_Tess: PackedScene = preload("res://scenes/battle/first_tesseract.tscn")

var battler_compendium = {
	"Fenik":scene_Fenik,
	#"Virus":scene_Virus,
	#"Comet":scene_Comet,
	#"Flora":scene_Flora
}

var boss_compendium = {
	"FirstTesseract":scene_Tess
}

func _ready() -> void:
	print("Step 1: Load Battles")
	boss_compendium["FirstTesseract"] = scene_Tess.instantiate();
	for key in battler_compendium:
		battler_compendium[key]= battler_compendium[key].instantiate();	
	global_battle_information._queueParticipants("Fenik",battler_compendium["Fenik"]);
	#global_battle_information._queueParticipants("Comet",battler_compendium["Comet"]);
	global_battle_information._queueEnemies("FirstTesseract",boss_compendium["FirstTesseract"]);
