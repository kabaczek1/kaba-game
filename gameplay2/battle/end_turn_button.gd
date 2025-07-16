extends Button

func _ready() -> void:
	EventBus.player_turn_started.connect(on_player_turn_started)

func _pressed() -> void:
	disabled = true
	EventBus.player_turn_ended.emit()

func on_player_turn_started():
	print("test")
	disabled = false
