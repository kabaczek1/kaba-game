extends Node

@export var cursor1: Cursor
@export var cursor2: Cursor
@export var cursor3: Cursor
@export var cursor4: Cursor
@export var cursor5: Cursor

var are_cursors_left = true

func _ready() -> void:
	cursors_left()


func _input(event):
	if event.is_action_pressed("toggle_sprite"):
		if are_cursors_left:
			cursors_right()
			are_cursors_left = false
		else:
			cursors_left()
			are_cursors_left = true

func cursors_left():
	cursor1.update_position(Vector2i(128,96))
	cursor2.update_position(Vector2i(128,128))
	cursor3.update_position(Vector2i(128,160))
	cursor4.update_position(Vector2i(128,192))
	cursor5.update_position(Vector2i(128,224))

func cursors_right():
	cursor1.update_position(Vector2i(192,96))
	cursor2.update_position(Vector2i(192,128))
	cursor3.update_position(Vector2i(192,160))
	cursor4.update_position(Vector2i(192,192))
	cursor5.update_position(Vector2i(192,224))
