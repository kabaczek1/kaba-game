extends Node

class_name PlayerInputController

@export var state_machine: StateMachine

var idle_state

func _ready() -> void:
	EventBus.cursor_cell_changed.connect(func (cell):
		state_machine.state.handle_cursor_move(cell)
	)
	EventBus.cursor_cell_clicked.connect(func (cell):
		state_machine.state.handle_cursor_click(cell)
	)
	EventBus.player_turn_started.connect(func ():
		state_machine.set_default_state_and_push(idle_state)
	)
	idle_state = IdleState.new(state_machine)
	state_machine.set_default_state_and_push(idle_state)
