extends PanelContainer

@export var health_text:Label;
@export var mp_text:Label;
@export var health_bar:TextureProgressBar;
@export var mp_bar:TextureProgressBar;
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
	health_text.text = str(held_hero._get_battle_data().current_hp)
	health_bar.value = held_hero._get_battle_data().current_hp;
	health_bar.max_value = held_hero._get_battle_data().stat_dict["maxHP"][1];

func update_mp()->void:
	mp_text.text = str(held_hero._get_battle_data().current_mp)
	mp_bar.value = held_hero._get_battle_data().current_mp;
	mp_bar.max_value = held_hero._get_battle_data().stat_dict["maxMP"][1];
