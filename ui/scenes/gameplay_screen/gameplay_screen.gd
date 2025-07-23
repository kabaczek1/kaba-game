extends Node2D

@export var mission_summary_button: Button
@export var mission_label: Label
@export var current_team_container: Container
@export var gameplay_node: Node

func _ready() -> void:
	mission_summary_button.pressed.connect(func ():
		GameplayController.end_mission_gameplay()
	)
	mission_label.text = MissionController.current_mission.name
	
	for character in GlobalController.team:
		var label = Label.new()
		label.text = character.name
		current_team_container.add_child(label)
	
	GameplayController.load_gameplay_node(gameplay_node)
		
	SceneController.scene_loaded.emit()
	
