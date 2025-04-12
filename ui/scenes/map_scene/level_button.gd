extends Button

var level: LevelResource

func _pressed() -> void:
	RunController.start_level(level)
