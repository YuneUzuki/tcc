extends Action

func _actionScript() -> void:
	print("Fly")
	$"../.."._is_character_flying = true
	emit_signal("_action_done")
