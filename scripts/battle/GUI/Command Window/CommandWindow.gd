extends PanelContainer

@onready var menuOne = $BattleCommands;

@onready var layerZero = $BattleCommands/Layer0
@onready var layerOne = $BattleCommands/Layer1
@onready var layerTwo =$BattleCommands/Layer2
@onready var backButton =$BattleCommands/Buttonback

var layer = 0;

func _ready() -> void:
	pass

func _on_button_fight_pressed() -> void:
	gl_battle.currently_selected_hero.skill_chosen = gl_battle.currently_selected_hero.battle_data.skillSet[0] # Replace with function body.
	nav_layer(2);
	layer_check();

func _on_button_skills_pressed() -> void:
	nav_layer(1);
	layer_check();

func nav_layer(incr:int)->void:
	layer += incr;

func layer_check()->void:
	if (layer == 0):
		layerZero.show()
		layerOne.hide()
		layerTwo.hide()
		backButton.hide()
	elif (layer == 1):
		layerZero.hide()
		layerOne.show()
		layerTwo.hide()
		backButton.show()
	elif (layer == 2):
		layerZero.hide()
		layerOne.hide()
		layerTwo.show()
		backButton.show()

func _on_buttonback_pressed() -> void:
	nav_layer(-1);
	layer_check();

func cancel_out():
	gl_battle.currently_selected_hero.skill_chosen = null;
 
