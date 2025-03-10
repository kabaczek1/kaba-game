extends Label

func _enter_tree() -> void:
	EventBus.turn_number_changed.connect(update_label)

func _exit_tree() -> void:
	EventBus.turn_number_changed.disconnect(update_label)
	
func update_label(value):
	text = str(value)
