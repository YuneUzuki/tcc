extends Node
class_name Action

@export var _action_name:String
@export var _action_ui_color:Color

signal _action_done
signal _damage_dealt

func _ready() -> void:
	_damage_dealt.connect(StateManager._checkHp)
	_action_done.connect(TurnManager._nextTurn)

func _actionScript() -> void:
	pass
