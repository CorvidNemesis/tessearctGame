extends CanvasLayer

@export var hud: PackedScene
@onready var battle_commands = $ActionsAndLabel;
@onready var hud_holder = $MarginContainer/HudArea/HudContainer; 
@onready var skill_label = $"Skill Label";

var skill_label_origin:Vector2;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	skill_label_origin = skill_label.global_position;
	clean_hud_holder();
	setup_battlers();

## Removes all huds left over from prior battles.
func clean_hud_holder()-> void:
	for box in hud_holder.get_children():
		box.queue_free();

func setup_battlers()->void:
	for battler in gl_battle.partaking_heroes:
		var box_instance = hud.instantiate();
		hud_holder.add_child(box_instance)
		box_instance._assign_battler(battler);
		box_instance._update_ui();
		
func _personalize_ui(hero:BattleHero)->void:
	battle_commands._setup_ui(hero)

func _display_skill(text:String)->void:
	print("using " + text)
	skill_label.text = text;
	var tween = create_tween()
	tween.tween_property(skill_label,"global_position",Vector2(skill_label.global_position.x-skill_label.size.x,skill_label.global_position.y),1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	await tween.finished
	tween.tween_property(skill_label,"global_position",Vector2(skill_label.global_position.x-skill_label.size.x,skill_label.global_position.y),1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	skill_label.hide()
	tween.tween_property(skill_label,"global_position",Vector2(skill_label.global_position.x+(skill_label.size.x)*2,skill_label.global_position.y),1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	skill_label.show()
