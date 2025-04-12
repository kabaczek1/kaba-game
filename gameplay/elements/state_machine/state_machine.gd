extends Node

class_name StateMachine

var default_state: State

var state_stack: Array[State] = []
var state

func push_state(new_state: State):
	if state:
		state.exit()
	state_stack.push_back(new_state)
	state = state_stack.back()
	state.enter()
	EventBus.state_entered.emit(state.name)

func pop_state():
	if state:
		state.exit()
		state_stack.pop_back()
	var state_on_stack = state_stack.back()
	if state_on_stack:
		state = state_on_stack
		state.enter()
		EventBus.state_entered.emit(state.name)

func set_state(new_state: State):
	state_stack.clear()
	push_state(new_state)

func reset_and_set_state(new_state: State):
	state_stack.clear()
	push_state(default_state)
	push_state(new_state)

func set_default_state_and_push(new_state: State):
	default_state = new_state
	push_state(new_state)
