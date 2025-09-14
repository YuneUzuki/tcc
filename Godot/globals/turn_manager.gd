extends Node

var _entity_array:Array
var _turn_order:Array
var _current_turn = -1

signal _playable_turn
signal _enemy_turn

func _setEntities(player:Array, enemy:Array) -> void:
	_entity_array = player + enemy
	_randomizeTurns()
	
func _randomizeTurns() -> void:
	_turn_order = []
	
	var aux_bool = false
	while !aux_bool:
		var aux_int = RandomNumberGenerator.new().randi_range(0, len(_entity_array)-1)
		if aux_int not in _turn_order:
			_turn_order.append(aux_int)
		if len(_turn_order) == len(_entity_array):
			aux_bool = true
			
	_current_turn = -1

func _nextTurn() -> void:
	print("Next turn")
	if _current_turn < len(_entity_array)-1: _current_turn += 1
	else: _current_turn = 0
	var current_turn = _turn_order[_current_turn]
	
	print(_entity_array[current_turn]._is_playable)
	if _entity_array[current_turn]._health > 0:
		if _entity_array[current_turn]._is_playable:
			print("Playable")
			emit_signal("_playable_turn")
			_entity_array[current_turn]._startTurn()
		else:
			print("Its going in here")
			print("Enemy")
			emit_signal("_enemy_turn")
			_entity_array[current_turn]._startTurn()
			_entity_array[current_turn]._actions[RandomNumberGenerator.new().randi_range(0, len(_entity_array[current_turn]._actions)-1)]._actionScript()
	else:
		_nextTurn()
