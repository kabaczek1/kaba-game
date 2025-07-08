extends EmptyAbilityState

class_name InputState

var unit: GridUnit
var ability: Ability
var input_step: AbilityInputStep

var available_cells: Array[Vector2i]

func _init(
	_state_machine: StateMachine,
	_ability_input_controller: AbilityInputController,
	_unit: GridUnit,
	_name: String = "InputState") -> void:
	super(_state_machine, _ability_input_controller, _name)
	unit = _unit

func enter():
	print("InputState enter")
	super()
	if unit.moved:
		return
	aic.reset_ability_options()
	ability = unit.unit_res.move_ability
	if ability.input_steps.is_empty():
		return
	input_step = ability.input_steps[0]
	
	var initial_cells = BattleController.bs.main_grid.get_shape_around_cell(ability.grid_range, unit.cell, input_step.shape)
	var level_cells = BattleController.level.get_ground_tiles()
	print(level_cells)
	for cell in initial_cells:
		if cell in level_cells:
			if BattleController.bs.grid_navigation.find_path(unit.cell, cell, level_cells).size() -1 <= ability.grid_range:
				available_cells.append(cell)
	
	#available_cells = bc.bs.main_grid.get_shape_around_cell(ability.grid_range, unit.cell, input_step.shape)
	bc.bs.range_grid.clear_all_cells()
	bc.bs.range_grid.modulate.a = 1
	bc.bs.range_grid.fill_cells(available_cells)

func exit():
	print("InputState exit")
	super()
	bc.bs.grid_path.clear_path()
	bc.bs.range_grid.clear_all_cells()
	bc.bs.range_grid.modulate.a = 1

func handle_cursor_move(cell: Vector2i):
	if available_cells.has(cell):
		var path = bc.bs.grid_navigation.find_path(unit.cell, cell, available_cells)
		bc.bs.grid_path.cells_array = path
	else:
		bc.bs.grid_path.clear_path()

func handle_cursor_click(cell: Vector2i):
	if available_cells.has(cell):
		aic.add_ability_option(input_step.option_key, cell)
		bc.bs.grid_path.clear_path()
		aic.resolve_ability(unit, ability)
		pop_state()
	else:
		bc.bs.grid_path.clear_path()

func handle_unit_selected(_unit: GridUnit):
	pass

func handle_unit_deselected(_unit: GridUnit):
	pop_state()
	
func handle_unit_glance_started(_unit: GridUnit):
	reset_and_set_state(GlanceState.new(state_machine, aic, _unit))
	pass
	
func handle_unit_glance_stopped(_unit: GridUnit):
	pass
