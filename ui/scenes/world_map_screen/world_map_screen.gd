extends Node2D

@export var war_room_button: Button
#temp
@export var mission_button: Button

func _ready() -> void:
	war_room_button.pressed.connect(func ():
		print(war_room_button)
		SceneController.go_to_war_room()
	)
	#temp
	mission_button.pressed.connect(func ():
		print(mission_button)
		SceneController.go_to_gameplay()
	)
	SceneController.scene_loaded.emit()
