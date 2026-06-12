extends Node2D

@onready var label = $Node2D/Label
@onready var effector = $AnimationPlayer

func play():
	effector.play("Damage")
