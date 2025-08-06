extends Node

func _ready() -> void:
	EventBus.enemy_turn_started.connect(func():
		print("BUahahah >:(")
		var timer = get_tree().create_timer(3.0)
		timer.timeout.connect(func():
			GameplayController.end_enemy_turn()
		)
	)
