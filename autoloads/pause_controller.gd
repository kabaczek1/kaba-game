extends Node2D

var paused = false
@onready var animation_player = %AnimationPlayer
@export var animation_name: String = "slide_pause_menu"

func _process(_delta):
	if Input.is_action_just_pressed("pause") and not(SceneController.in_transition):
		if paused:
			resume_game()
		else:
			pause_game()

func pause_game():
	if paused:
		print("game already paused!")
		return
	get_tree().paused = true
	paused = true
	animation_player.play(animation_name)

func resume_game():
	if not(paused):
		print("game already resumed!")
		return
	paused = false
	get_tree().paused = false
	animation_player.play_backwards(animation_name)
