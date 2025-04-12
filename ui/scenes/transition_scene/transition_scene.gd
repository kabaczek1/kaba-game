extends CanvasLayer

signal transition_scene_animation_fully_in()

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("fade_in")

func transition_animation_in():
	transition_scene_animation_fully_in.emit()

func animate_out():
	animation_player.play("fade_out")
