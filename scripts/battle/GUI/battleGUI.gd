extends CanvasLayer

@export var battleBox: PackedScene
@onready var actionBox = $Actions;
@onready var enemyHP = $MarginContainer/EnemyHPBar/EnemyHP
var origin:Vector2;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	origin = actionBox.global_position
	gl_battle.battle_signal_open_actions.connect(_showMenu)
	cleanUp_ui();
	setup_battlers(gl_battle.partaking_heroes);

# TODO set filepath to a variable

func cleanUp_ui()-> void:
	for box in $"MarginContainer/BoxZone/Player Window".get_children():
		box.queue_free();

func setup_battlers(partaking: Array)->void:
	var count = 1;
	for battler in partaking:
		var box_instance = battleBox.instantiate();
		# TODO: REPLACE 1 WITH GLOBAL VARIABLE
		var stats = battler[1]._get_battle_data();
		$"MarginContainer/BoxZone/Player Window".add_child(box_instance);
		box_instance._setup_displayables(stats.display_name + str(count),stats.stat_dict["maxHP"],stats.stat_dict["maxMP"])
		count +=1;

func _showMenu()->void:
	var tween = create_tween();
	tween.tween_property(actionBox,"position",Vector2(origin.x,origin.y+actionBox.size.y),0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT);
	# sets up the skill box beforehand.
	# idk if this was inovative or really stupid.
	# TODO: exchange the emit signal for a function in the battleCommands menu
	gl_battle.emit_signal("battle_signal_prepareSkillset")
	actionBox.layer = 0;
	actionBox.layer_check();
	actionBox.show()


func _on_begin_button_pressed() -> void:
	enemyHP._setup();
	print("3 2 1 Go!")
	gl_battle.emit_signal("battle_signal_phase_start_turn")
