extends Action

func _actionScript() -> void:
	var target:Entity = StateManager._getTarget($"../.."._is_playable)
	if target != null:
		var damage = $"../.."._attack
		target._setHealth(target._health-damage)
		emit_signal("_damage_dealt")
		emit_signal("_action_done")
	else:
		emit_signal("_action_done")
