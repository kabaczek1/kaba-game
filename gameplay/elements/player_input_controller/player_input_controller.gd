extends Node

class_name PlayerInputController

@export var state_machine: StateMachine

var idle_state
var no_input_state

var selected_unit: Unit

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
	EventBus.player_turn_ended.connect(func ():
		state_machine.set_default_state_and_push(no_input_state)
	)
	idle_state = IdleState.new(state_machine)
	state_machine.set_default_state_and_push(idle_state)
	no_input_state = NoInputState.new(state_machine)
	state_machine.set_default_state_and_push(no_input_state)


func select_unit_by_cell(cell: Vector2i):
	var unit = GameplayController.gamestate[cell].unit
	if unit:
		selected_unit = unit
		EventBus.unit_selected.emit(selected_unit)

func deselect_unit():
	selected_unit = null
	EventBus.unit_deselected.emit()

#unit > character > move ability:
# reach
# reach_validator
# target_validator
# 
