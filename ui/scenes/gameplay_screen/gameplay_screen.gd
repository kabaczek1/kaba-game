extends Node2D

@export var mission_summary_button: Button

func _ready() -> void:
	mission_summary_button.pressed.connect(func ():
		print(mission_summary_button)
		SceneController.go_to_mission_summary()
	)
	SceneController.scene_loaded.emit()
