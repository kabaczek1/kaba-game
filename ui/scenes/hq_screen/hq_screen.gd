extends Node2D

@export var world_map_button: Button
@export var workshop_button: Button
@export var tavern_button: Button
@export var quarters_button: Button

func _ready() -> void:
	world_map_button.pressed.connect(func ():
		print(world_map_button)
	)
	workshop_button.pressed.connect(func ():
		print(workshop_button)
	)
	tavern_button.pressed.connect(func ():
		print(tavern_button)
	)
	quarters_button.pressed.connect(func ():
		print(quarters_button)
	)
	EventBus.scene_loaded.emit()
