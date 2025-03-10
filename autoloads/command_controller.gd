extends Node

signal command_undo_status_changed(bool)

var command_queue: Array[Command] = []
var command_index: int = 0

var is_undo_possible = false:
	set(value):
		command_undo_status_changed.emit(value)
		is_undo_possible = value

func _ready() -> void:
	EventBus.player_turn_ended.connect(reset)

func add(command: Command):
	print(command.name)
	command_queue.append(command)
	#command_queue[command_index] = command
	command.execute()
	command_index += 1
	is_undo_possible = true

func undo():
	if command_index == 1:
		is_undo_possible = false
	command_queue[command_index - 1].undo()
	command_queue.pop_back()
	command_index -= 1

func reset():
	command_queue = []
	command_index = 0
	is_undo_possible = false
