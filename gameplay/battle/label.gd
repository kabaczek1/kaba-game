extends Label

func _enter_tree() -> void:
	EventBus.state_entered.connect(update_label)

func _exit_tree() -> void:
	EventBus.state_entered.disconnect(update_label)
	
func update_label(value):
	text = value
