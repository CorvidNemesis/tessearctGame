extends MarginContainer

@onready var action_commands = $ButtonsAndFunction
@onready var command_holder = $"ButtonsAndFunction/Button Holder";
@onready var description = $ButtonsAndFunction/SkillDesciption
@onready var enemy_holder = $"ButtonsAndFunction/Enemy Holder";
@export var enemy_button: PackedScene;
@export var skill_button: PackedScene;
@onready var skill_holder = $"ButtonsAndFunction/Skill Holder";
@onready var back = $ButtonsAndFunction/Back;
var origin_place: Vector2;
@export var current_menu: MENU_LEVEL = MENU_LEVEL.ACTION_SELECT;

enum MENU_LEVEL { 
ACTION_SELECT, 
TECHNIQUES,
ITEMS, 
ENEMY_SELECTION,
}

func _ready() -> void:
	origin_place = self.global_position
	gl_battle.assign_skill.connect(setup_enemies)
	gl_battle.targeting.connect(move_back)

func _setup_ui(hero:BattleHero)->void:
	create_skills(hero._get_battle_data().skillSet)
	self.show()
	await get_tree().create_timer(1.0).timeout
	var tween = create_tween()
	tween.tween_property(self,"global_position",Vector2(origin_place.x+self.size.x,self.global_position.y),1.0).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	pass

func _hide_ui()->void:
	var tween = create_tween()
	tween.tween_property(self,"global_position",Vector2(origin_place.x-self.size.x,self.global_position.y),1.0).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	await tween.finished
	self.hide()

func create_skills(skill_list:Array)->void:
	clean_up_skills();
	for skill in skill_list:
		print(" CREATING SKILL " + skill.name)
		var skill_instance = skill_button.instantiate()
		skill_holder.add_child(skill_instance);
		skill_instance._create_skill(skill);
		skill_instance.set_description.connect(update_description)

func clean_up_skills():
	for button in skill_holder.get_children():
		if button is Button:
			button.queue_free()

func _on_technique_pressed() -> void:
	current_menu = MENU_LEVEL.TECHNIQUES;
	level_check()

func update_description(text:String)->void:
	description.text = text;

func setup_enemies()->void:
	clean_enemy_holder()
	var index =0;
	for enemy in gl_battle.partaking_enemies:
		if enemy._is_alive():
			var enemy_instance = enemy_button.instantiate()
			enemy_holder.add_child(enemy_instance);
			enemy_instance._create_enemy(enemy,index);
			index+=1;
	description.hide();
	skill_holder.hide();
	enemy_holder.show();

func clean_enemy_holder()->void:
	for button in enemy_holder.get_children():
		if button.text != "Mass Summation":
			button.queue_free();
		else:
			button.hide();

func level_check()->void:
	match current_menu:
		MENU_LEVEL.ACTION_SELECT:
			back.hide();
			description.hide()
			command_holder.show();
			skill_holder.hide()
			enemy_holder.hide()
		MENU_LEVEL.TECHNIQUES:
			back.show();
			description.show()
			command_holder.hide();
			skill_holder.show()
			enemy_holder.hide()
		MENU_LEVEL.ENEMY_SELECTION:
			back.show();
			command_holder.hide();
			skill_holder.hide()
			enemy_holder.show()

func _on_back_pressed() -> void:
	level_check();
	
func move_back()->void:
	print("Moving to next battler")
	current_menu = MENU_LEVEL.ACTION_SELECT;
	level_check()
	gl_battle.emit_signal("next_turn");
