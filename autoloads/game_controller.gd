extends Node

func start_new_run():
	RunController.setup_new_run()
	SceneController.change_to_map_scene()
