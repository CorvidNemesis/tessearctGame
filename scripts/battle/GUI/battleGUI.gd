extends CanvasLayer

@export var battleBox: PackedScene
@onready var actionBox = $MarginContainer/HBoxContainer/Actions;
@onready var enemyHP = $MarginContainer/EnemyHPBar/EnemyHP
var origin:Vector2;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	origin = actionBox.global_position
	gl_battle.battle_signal_open_actions.connect(_showMenu)
	gl_battle.battle_signal_close_actions.connect(_hideMenu)
	cleanUp_ui();
	setup_battlers(gl_battle.partaking_heroes);

func cleanUp_ui()-> void:
	for box in $"MarginContainer/BoxZone/Player Window".get_children():
		box.queue_free();

func setup_battlers(partaking: Array)->void:
	var count = 1;
	for battler in partaking:
		var box_instance = battleBox.instantiate();
		# TODO: REPLACE 1 WITH GLOBAL VARIABLE
		var stats = battler[gl_battle.AQ_SCENE_INDEX]._get_battle_data();
		$"MarginContainer/BoxZone/Player Window".add_child(box_instance);
		box_instance.asc_battler = battler[gl_battle.AQ_SCENE_INDEX];
		box_instance._setup_displayables(stats.display_name + str(count),stats.stat_dict["maxHP"],stats.stat_dict["maxMP"])
		count +=1;

func _showMenu()->void:
	gl_battle.emit_signal("battle_signal_prepareSkillset")
	actionBox.layer = 0;
	actionBox.layer_check();
	actionBox.show()

func _hideMenu()->void:
	actionBox.layer = 0;
	actionBox.layer_check();
	actionBox.hide()

func _on_begin_button_pressed() -> void:
	enemyHP._setup();
	print("3 2 1 Go!")
	gl_battle.emit_signal("battle_signal_phase_start_turn")
