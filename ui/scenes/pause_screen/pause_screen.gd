extends Node2D

@export var resume_button: Button


func _ready() -> void:
	resume_button.pressed.connect(func ():
		print(resume_button)
	)
