extends Action

func _actionScript() -> void:
	print("Defend")
	$"../.."._defense_boost = int($"../.."._defense/2)
	emit_signal("_action_done")
