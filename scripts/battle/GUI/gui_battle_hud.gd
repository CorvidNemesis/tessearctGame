extends PanelContainer

@export var health_text:Label;
@export var mp_text:Label;
@export var health_bar:ProgressBar;
@export var mp_bar:ProgressBar;
@export var health_bar_tween:ProgressBar;
@export var mp_bar_tween:ProgressBar;
@export var selection:TextureButton;

var face:AnimatedSprite2D;

var held_hero: BattleHero;

func _ready() -> void:
	pass

func _assign_battler(creature: BattleHero)->void:
	held_hero = creature;
	face = held_hero.face;
	face.play("default")
	
func _update_ui():
	update_hp();
	update_mp();

func update_hp()->void:
	health_text.text = str(held_hero.battle_data.current_hp) + " / " + str(held_hero.battle_data.battle_stat_dict['maxHP'])
	health_bar.value = held_hero.battle_data.current_hp;
	health_bar.max_value = held_hero.battle_data.battle_stat_dict["maxHP"];
	

func update_mp()->void:
	mp_text.text =str(held_hero.battle_data.current_mp) + " / " + str(held_hero.battle_data.battle_stat_dict['maxMP'])
	mp_bar.value = held_hero.battle_data.current_mp;
	mp_bar.max_value = held_hero.battle_data.battle_stat_dict["maxMP"];



func _enable_selection()->void:
	selection.disabled = false;

func _disable_selection()->void:
	selection.disabled = true;
