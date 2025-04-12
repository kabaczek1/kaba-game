extends EmptyAbilityState

class_name GlanceState

var unit: GridUnit
var ability: Ability
var input_step: AbilityInputStep

func _init(
	_state_machine: StateMachine,
	_ability_input_controller: AbilityInputController,
	_unit: GridUnit,
	_name: String = "Glance") -> void:
	super(_state_machine, _ability_input_controller, _name)
	unit = _unit

func enter():
	super()
	if unit.moved:
		return
	ability = unit.unit_res.move_ability
	if ability.input_steps.is_empty():
		return
	input_step = ability.input_steps[0]
	var available_cells = bc.bs.main_grid.get_shape_around_cell(ability.grid_range, unit.cell, input_step.shape)
	bc.bs.range_grid.clear_all_cells()
	bc.bs.range_grid.modulate.a = 0.5
	bc.bs.range_grid.fill_cells(available_cells)

func exit():
	super()
	bc.bs.range_grid.clear_all_cells()
	bc.bs.range_grid.modulate.a = 1

func handle_cursor_click(cell: Vector2i):
	super(cell)

func handle_cursor_move(cell: Vector2i):
	super(cell)

func handle_unit_selected(_unit: GridUnit):
	super(_unit)

func handle_unit_deselected(_unit: GridUnit):
	super(_unit)
	
func handle_unit_glance_started(_unit: GridUnit):
	super(_unit)
	
func handle_unit_glance_stopped(_unit: GridUnit):
	pop_state()
