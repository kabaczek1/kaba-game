extends Node2D

@export var button_container: Container
@export var level_button: PackedScene

func _ready() -> void:
	#for level in RunController.levels:
		#var button = level_button.instantiate()
		#button.text = level.level_name
		#button.level = level
		#button_container.add_child(button)
	EventBus.scene_loaded.emit()
