extends Node2D

var scene_BassBrash: PackedScene = preload("res://scenes/characterScenes/battleCharacter_bass.tscn")
var scene_TemPlate: PackedScene = preload("res://scenes/characterScenes/battleTemplate.tscn")

var scene_Tess: PackedScene = preload("res://scenes/battle/first_tesseract.tscn")

var battler_compendium = {
	"Bass Brash":scene_BassBrash,
	"Template":scene_TemPlate
}

var boss_compendium = {
	"FirstTesseract":scene_Tess
}

func _ready() -> void:
	print("Step 1: Load Battles")
	boss_compendium["FirstTesseract"] = scene_Tess.instantiate();
	battler_compendium["Bass Brash"] = scene_BassBrash.instantiate();
	battler_compendium["Template"] = scene_TemPlate.instantiate();
	globalBattleInfo._queueParticipants(battler_compendium["Bass Brash"]);
	globalBattleInfo._queueParticipants(battler_compendium["Template"]);
	globalBattleInfo._queueEnemies(boss_compendium["FirstTesseract"]);
