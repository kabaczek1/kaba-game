extends State

class_name EmptyAbilityState

var aic: AbilityInputController

var bc = BattleController

func _init(
	_state_machine: StateMachine,
	_ability_input_controller: AbilityInputController,
	_name: String = "EmptyAbilityState") -> void:
	super(_state_machine, _name)
	aic = _ability_input_controller

func enter():
	super()

func exit():
	super()

func handle_cursor_click(_cell: Vector2i):
	#print("AbilityInputController EmptyState handle_cursor_click")
	pass

func handle_cursor_move(_cell: Vector2i):
	#print("AbilityInputController EmptyState handle_cursor_move")
	pass

func handle_unit_selected(unit: GridUnit):
	reset_and_set_state(InputState.new(state_machine, aic, unit))

func handle_unit_deselected(_unit: GridUnit):
	pass
	
func handle_unit_glance_started(unit: GridUnit):
	push_state(GlanceState.new(state_machine, aic, unit))
	pass
	
func handle_unit_glance_stopped(_unit: GridUnit):
	pass
