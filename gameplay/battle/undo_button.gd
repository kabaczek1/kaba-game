extends Button

func _ready() -> void:
	CommandController.command_undo_status_changed.connect(_on_command_undo_status_changed)

func _pressed() -> void:
	CommandController.undo()

func _on_command_undo_status_changed(value: bool):
	disabled = not(value)
