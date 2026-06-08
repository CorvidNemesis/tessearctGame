extends Control

@onready var timer = $BeforeHit;
@onready var cooldown = $AfterHit;
@onready var result_label = $Sprite2D/numberRoll;
@onready var animation = $Sprite2D/AnimationPlayer;
@onready var bar = $ProgressBar

var display:int;

func _store(value:int)->void:
	display = value;
	
func timer_trigger()->void:
	animation.play("Spinning")
	timer.start();

func _update(value:int)->void:
	result_label.text = str(value);
	animation.play("reveal");
	timer.stop();

func _loss(value:int)->void:
	result_label.text = "[shake rate=20.0 level=5 connected=1]" + str(value)+ "[/shake]"
	animation.play("Loss");

func _win(value:int)->void:
	result_label.text = "[wave amp=50.0 freq=5.0 connected=1]" + str(value)+ "[/wave]"
	animation.play("Victory");

func _tie(value:int)->void:
	animation.play("Tie");

func _remaining(skill:BattleSkill)->void:
	bar.value = skill.safteyRemaining;
	bar.max_value = skill.hit_count;

func _on_timer_timeout() -> void:
	_update(display)
 # Replace with function body.

func _on_after_hit_timeout() -> void:
	_update(display)
