extends Node

class_name AbilityInputController

@export var state_machine: StateMachine

var empty_state

#region ability options
var ability_options: Dictionary[String, Variant]

func reset_ability_options():
	ability_options.clear()

func add_ability_option(key: String, value):
	ability_options.set(key, value)

func get_ability_options():
	return ability_options
#endregion


func _ready() -> void:
	EventBus.cursor_cell_changed.connect(func (cell):
		state_machine.state.handle_cursor_move(cell)
	)
	EventBus.cursor_cell_clicked.connect(func (cell):
		state_machine.state.handle_cursor_click(cell)
	)
	EventBus.unit_selected.connect(func (unit):
		state_machine.state.handle_unit_selected(unit)
	)
	EventBus.unit_deselected.connect(func (unit):
		state_machine.state.handle_unit_deselected(unit)
	)
	EventBus.unit_glance_started.connect(func (unit):
		state_machine.state.handle_unit_glance_started(unit)
	)
	EventBus.unit_glance_stopped.connect(func (unit):
		state_machine.state.handle_unit_glance_stopped(unit)
	)
	EventBus.player_turn_started.connect(func ():
		state_machine.set_default_state_and_push(empty_state)
	)
	empty_state = EmptyAbilityState.new(state_machine, self)
	state_machine.set_default_state_and_push(empty_state)

func resolve_ability(unit: GridUnit, ability: Ability):
	print("resolve_ability: ", unit, ability)
	var ability_command = ability.command.new(unit, ability_options)
	CommandController.add(ability_command)
	
