extends Node

var _playable_entities:Array
var _player_hp:int
var _player_taunting

var _enemy_entities:Array
var _enemy_hp:int
var _enemy_taunting

signal _target_not_found

func _setEntities(entity_list) -> void:
	for entity in entity_list:
		if entity._is_playable:
			_playable_entities.append(entity)
		else:
			_enemy_entities.append(entity)
		#for action in entity.actions TODO
	_checkHp()
	TurnManager._setEntities(_playable_entities, _enemy_entities)

func _checkHp() -> void:
	var player_health_aux = 0
	var enemy_health_aux = 0
	for entity in _playable_entities:
		player_health_aux += entity._health
	for entity in _enemy_entities:
		enemy_health_aux += entity._health
	print(enemy_health_aux)
	print(player_health_aux)
	
	_enemy_hp = enemy_health_aux
	_player_hp = player_health_aux

func _getTarget(get_enemy:bool) -> Node:
	var is_target_valid = false
	var iterations = 0
	if get_enemy:
		#print("Its getting into get enemy")
		if !_enemy_taunting:
			while !is_target_valid and iterations < len(_enemy_entities):
				var aux = RandomNumberGenerator.new().randi_range(0, len(_enemy_entities)-1)
				if _enemy_entities[aux]._health > 0 and !_enemy_entities[aux]._is_character_flying:
					is_target_valid = true
					#print(_enemy_entities[aux])
					return _enemy_entities[aux]
				iterations += 1
				#print(iterations)
		else:
			var aux = 0
			for entity in _enemy_entities:
				if entity == _enemy_taunting: 
					#print(_enemy_entities[aux])
					return _enemy_entities[aux]
				else: aux+=1
	else:
		#print("Its getting into get player")
		if !_player_taunting:
			if !_player_taunting:
				while !is_target_valid and iterations < len(_playable_entities):
					var aux = RandomNumberGenerator.new().randi_range(0, len(_playable_entities)-1)
					if _playable_entities[aux]._health > 0 and !_playable_entities[aux]._is_character_flying:
						is_target_valid = true
						#print(_playable_entities[aux])
						return _playable_entities[aux]
					iterations += 1
					#print(iterations)
		else:
			var aux = 0
			for entity in _playable_entities:
				if entity == _player_taunting: 
					#print(_playable_entities[aux])
					return _playable_entities[aux]
				else: aux+=1
	#print("Its getting here where it should")
	emit_signal("_target_not_found")
	#print("Target not found")
	return null
