class_name battlePlayer
extends Node2D

@export var battleStats: statsResource;
@export var spriteSheet: AnimatedSprite2D;
@export var animationEffects: AnimationPlayer;
@export var selectionButton: Button;

var world_x = global_position.x
var world_y = global_position.y

var skillChosen:BattleSkill;

func _getStats():
	return battleStats

func _on_selection_pressed() -> void:
	print(battleStats.display_name)
