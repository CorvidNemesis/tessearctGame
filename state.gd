extends Node
class_name State

signal switch_state(state:State)

func _set_battle_manager():
	return get_parent().get_parent();

func enter_state()->void:
	pass

func exit_state()->void:
	pass

func update_state()->void:
	pass
