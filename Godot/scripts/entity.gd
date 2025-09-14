extends Node3D
class_name Entity

@export var _entity_id:String
@export var _attack:int
@export var _defense:int
@export var _defense_boost:int
@export var _max_health:int
@export var _health:int
@export var _is_playable:bool
@export var _actions:Array
@export var _is_character_flying:bool
@export var _is_character_taunting:bool

func _ready() -> void:
	_setActions()
	_startTurn()

func _startTurn() -> void:
	_is_character_flying = false
	_is_character_taunting = false
	_defense_boost = 0

func _setHealth(value:int) -> int:
	_health = value
	if _health <= 0:
		_health = 0
		_onDeath()
	if _health >= _max_health:
		_health = _max_health
	return _health

func _setActions() -> void:
	_actions = $Actions.get_children() if $Actions else []

func _onDeath() -> void:
	_is_character_flying = false
	_is_character_taunting = false
