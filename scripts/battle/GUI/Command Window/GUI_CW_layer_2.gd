extends VBoxContainer
# TODO: Move ALL of this to $Actions
@onready var skillCard = $SkillCard
@onready var enemyChoices = $EnemyChoices

func _ready() -> void:
	gl_battle.battle_signal_makeSkillCard.connect(setUp)

# Hands skillcard the manual for its setup
func setUp(skill:BattleSkill)->void:
	skillCard._make_the_card(skill)
	enemyChoices._setup_enemies()
	get_parent().get_parent().layer=2;
	get_parent().get_parent().layer_check();
