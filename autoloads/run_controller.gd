extends Node

@export var selected_team: Array[UnitResource]
@export var levels: Array[LevelResource]
var team: Array[UnitResource]
var level: LevelResource

func setup_new_run():
	print("setup_new_run")
	team = selected_team.duplicate(true)

func start_level(_level: LevelResource):
	print("start_level")
	level = _level
	SceneController.change_to_battle_scene()
