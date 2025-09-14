extends Node

func _ready() -> void:
	StateManager._setEntities(self.get_children())
