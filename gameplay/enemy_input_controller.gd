extends Node

func _ready() -> void:
	EventBus.enemy_turn_started.connect(func():
		print("BUahahah >:(")
		GameplayController.end_enemy_turn()
	)
