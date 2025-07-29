extends Node2D

@export var mission_summary_button: Button
@export var gameplay_node: Node

func _ready() -> void:
	mission_summary_button.pressed.connect(func ():
		GameplayController.end_mission_gameplay()
	)

	GameplayController.load_gameplay_node(gameplay_node)
		
	SceneController.scene_loaded.emit()
	
