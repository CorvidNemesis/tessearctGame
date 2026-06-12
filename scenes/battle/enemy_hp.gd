extends ProgressBar

func _ready()->void:
	gl_battle.battle_signal_ui_troop_hp.connect(_change);
	pass

func _setup()->void:
	var max:int =0;
	var curr:int =0;
	for enemy in gl_battle.partaking_enemies:
		var selected = enemy[gl_battle.AQ_SCENE_INDEX];
		max += selected.battle_data.stat_dict["maxHP"];
		curr += selected.battle_data._current_hp;
	self.max_value = max;
	self.value = curr;

func _change(user:BattleEntity,damage)->void:
	if user is BattlePlayer:
		var tween = create_tween();
		tween.tween_property(self,"value",value-damage,2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
