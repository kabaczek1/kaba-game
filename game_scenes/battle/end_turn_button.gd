extends Button

func _pressed() -> void:
	EventBus.player_turn_ended.emit()
