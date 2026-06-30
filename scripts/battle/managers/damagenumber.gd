extends Control

@export var damage_number: Label;
@export var multiplier: Label
@export var animaton: AnimationPlayer;

func _ready() -> void:
	pass
	
func _set_damage(value:int)->void:
	damage_number.text = str(value);

func _set_multiplier(value:float)->void:
	multiplier.text = str(value);

func _show_damage()->void:
	self.show()
	print(damage_number.text)
	animaton.play("Damage Display/normal")
	await animaton.animation_finished
