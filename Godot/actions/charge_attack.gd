extends Action

func _actionScript() -> void:
	print("Charge Attack")
	var target:Entity = StateManager._getTarget($"../.."._is_playable)
	if target != null:
		var damage = $"../.."._attack*2 - target._defense - target._defense_boost
		target._setHealth(target._health-damage)
		emit_signal("_damage_dealt")
		emit_signal("_action_done")
	else:
		emit_signal("_action_done")
