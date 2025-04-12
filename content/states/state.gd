extends Resource

class_name State

var name: String
var state_machine: StateMachine

func _init(_state_machine: StateMachine, _name: String = "State") -> void:
	name = _name
	state_machine = _state_machine
	assert(state_machine != null, "state_machine not set")

func enter():
	#print("STATE Enter  : ", name)
	pass

func exit():
	#print("STATE Exit   : ", name)
	pass

func handle_input(_event):
	pass

func handle_cursor_click(_cell: Vector2i):
	pass

func handle_cursor_move(_cell: Vector2i):
	pass

func pop_state():
	state_machine.pop_state()

func push_state(new_state: State):
	state_machine.push_state(new_state)

func set_state(new_state: State):
	state_machine.set_state(new_state)

func reset_and_set_state(new_state: State):
	state_machine.reset_and_set_state(new_state)
