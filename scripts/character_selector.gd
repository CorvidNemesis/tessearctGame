extends Control

var PATH = "res://scenes/characterScenes/"

@onready var character_button_holder = $VBoxContainer/CharacterSelectionList/CharacterIconHolder/HBoxContainer
@onready var character_info = $VBoxContainer/CharacterInfo/Panel/MarginContainer/ScrollContainer/Skills
@onready var characters_for_battle = $VBoxContainer/CharactersForBattle/HBoxContainer;
@onready var character_check = $"VBoxContainer/Character Number/MarginContainer/Button"
@export var character_button:PackedScene

var scene_Fenik: PackedScene = preload("res://scenes/characterScenes/Scene_Hero_Fenik.tscn")
var scene_Virus: PackedScene = preload("res://scenes/characterScenes/Scene_Hero_Virus.tscn")
var scene_Comet: PackedScene = preload("res://scenes/characterScenes/Scene_Hero_Comet.tscn")
var scene_Flora: PackedScene = preload("res://scenes/characterScenes/Scene_Hero_Flora.tscn")
var scene_Magia: PackedScene = preload("res://scenes/characterScenes/Scene_Hero_Magia.tscn")
var scene_Tess: PackedScene = preload("res://scenes/battle/Enemy Scenes/first_tesseract.tscn")
var scene_Tess_Blade: PackedScene = preload("res://scenes/battle/Enemy Scenes/tesseract_blade.tscn")
var scene_Nothing_There: PackedScene = preload("res://scenes/battle/Enemy Scenes/NothingsThere.tscn")


var battler_compendium = {
	"Fenik":scene_Fenik,
	"Virus":scene_Virus,
	"Comet":scene_Comet,
	"Flora":scene_Flora,
	"Magia":scene_Magia,
}

var boss_compendium = {
	"Magic Blase":scene_Tess_Blade,
	"FirstTesseract":scene_Tess,
	"Tesseract Blade":scene_Tess_Blade,
}

func _ready() -> void:
	_prepare_all_heroes()
	_prepare_all_enemies()
	_prepare_hero_buttons()

func _prepare_all_heroes()->void:
	print("Readying Heroes")
	for key in battler_compendium:
		battler_compendium[key]= battler_compendium[key].instantiate();
		battler_compendium[key].key_name = key;

func _prepare_all_enemies()->void:
	for key in boss_compendium:
		boss_compendium[key]= boss_compendium[key].instantiate();

func _prepare_hero_buttons()->void:
	for button in character_button_holder.get_children():
		button.queue_free();
	for key in battler_compendium:
		var hero =  battler_compendium[key];
		var hero_profile = hero.face.sprite_frames.get_frame_texture("default",0);
		var chara_button = character_button.instantiate();		
		chara_button.held_battler = hero;
		chara_button.texture_normal = hero_profile;
		character_button_holder.add_child(chara_button);
		chara_button.transfer_moveset.connect(update_descripton)
		chara_button.select.connect(party_selection)
	
func update_descripton(skills:Array)->void:
		for skill in character_info.get_children():
			skill.queue_free();
		for skill in skills:
			var label = Label.new()
			label.text = skill.name + "\n" + skill.description;
			character_info.add_child(label)

func party_selection(button)->void:
	if button.get_parent() == character_button_holder:
		button.reparent(characters_for_battle)
	else:
		button.reparent(character_button_holder)
	dungeon_permission()

func dungeon_permission()->void:
	var send_off = characters_for_battle.get_children().size();
	character_check.text = "SELECTED: " + str(send_off) + " / 10"
	if send_off > 0:
		character_check.disabled = false;
	else:
		character_check.disabled = true;

func _on_button_pressed() -> void:
	for button in characters_for_battle.get_children():
		gl_battle.partaking_heroes.append(button.held_battler)
	for key in boss_compendium:
		gl_battle.partaking_enemies.append(boss_compendium[key])

	global_functions.go_to_scene("res://scenes/battle/battle_scene.tscn") # Replace with function body.
