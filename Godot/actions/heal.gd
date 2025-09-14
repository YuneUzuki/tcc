extends Action

func _actionScript() -> void:
	print("Heal")
	var target:Entity = StateManager._getTarget(!$"../.."._is_playable)
	if target != null:
		target._setHealth(target._health+(target._health/5*2))
	emit_signal("_action_done")
