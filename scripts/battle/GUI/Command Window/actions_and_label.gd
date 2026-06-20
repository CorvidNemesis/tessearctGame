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
## The page of the menu the user is at
# 0 -> action commands, 1-> Skills and Items 2-> Enemy Targets(TEMP)
var level = 0;

func _ready() -> void:
	origin_place = self.global_position
	gl_battle.assign_skill.connect(setup_enemies)
	gl_battle.targeting.connect(move_back)

func _setup_ui(hero:BattleHero)->void:
	_create_skills(hero._get_battle_data().skillSet)
	description.hide()
	self.show()
	await get_tree().create_timer(1.0).timeout
	var tween = create_tween()
	tween.tween_property(self,"global_position",Vector2(origin_place.x+self.size.x,self.global_position.y),1.0).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	print("Activate UI")
	pass

func _hide_ui()->void:
	var tween = create_tween()
	tween.tween_property(self,"global_position",Vector2(origin_place.x-self.size.x,self.global_position.y),1.0).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	await tween.finished


func _create_skills(skill_list:Array)->void:
	clean_up_skills();
	for skill in skill_list:
		print(" CREATING SKILL " + skill.name)
		var skill_instance = skill_button.instantiate()
		skill_holder.add_child(skill_instance);
		skill_instance._create_skill(skill);
		skill_instance.set_description.connect(update_description)

func level_check()->void:
	level -= 1;
	if level <= 0:
		skill_holder.hide();
		command_holder.show();
		enemy_holder.hide();
		level = 0;
	elif level == 1:
		skill_holder.show();
		command_holder.hide();
		enemy_holder.hide();
	elif level == 2:
		skill_holder.hide();
		command_holder.hide();
		enemy_holder.show();
		
func clean_up_skills():
	for button in skill_holder.get_children():
		if button is Button:
			button.queue_free()

func _on_technique_pressed() -> void:
	skill_holder.show()
	description.text = "";
	description.show()
	command_holder.hide()
	level = 1;
	back.show()
	 # Replace with function body.

func update_description(text:String)->void:
	description.text = text;

func setup_enemies(skill_used:BattleSkill)->void:
	var target_type = skill_used.target;
	print(target_type)
	print("setting_up")
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

func _on_back_pressed() -> void:
	level_check();
	
func move_back(index:int)->void:
	print("Now onto the next battler")
	level_check();
	gl_battle.emit_signal("next_turn");
