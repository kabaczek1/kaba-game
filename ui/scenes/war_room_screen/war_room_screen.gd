extends Node2D

@export var world_map_button: Button
@export var magic_workshop_button: Button
@export var quarters_button: Button

func _ready() -> void:
	world_map_button.pressed.connect(func ():
		SceneController.go_to_world_map()
	)
	magic_workshop_button.pressed.connect(func ():
		SceneController.go_to_magic_workshop()
	)
	quarters_button.pressed.connect(func ():
		SceneController.go_to_quarters()
	)
	SceneController.scene_loaded.emit()
