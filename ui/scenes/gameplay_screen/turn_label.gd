extends Label

func _ready() -> void:
	EventBus.turn_number_changed.connect(func (turn_number):
		text = "Turn: %d" % [turn_number]
	)
