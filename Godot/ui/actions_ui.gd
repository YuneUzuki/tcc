extends Control

func _ready() -> void:
	TurnManager._playable_turn.connect(_enableMenu)
	TurnManager._enemy_turn.connect(_disableMenu)
	TurnManager._nextTurn()

func _enableMenu() -> void:
	print("Enable Menu")
	self.visible = true
	
	for button in %ActionButtons.get_children():
		button.queue_free()
	
	var entity_array = TurnManager._entity_array
	for action in entity_array[TurnManager._turn_order[TurnManager._current_turn]]._actions:
		var action_button = Button.new()
		action_button.text = action._action_name
		action_button.button_down.connect(action._actionScript)
		%ActionButtons.add_child(action_button)

func _disableMenu() -> void:
	print("Disable Menu")
	self.visible = false
