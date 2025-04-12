extends IdleState

class_name SelectState

var unit: GridUnit

func _init(_state_machine: StateMachine, _unit: GridUnit) -> void:
	super(_state_machine, "SelectState")
	unit = _unit

func enter():
	unit.select()
	super()
	#print(unit)
	#CommandController.add(SelectCommand.new(unit))
	#var unit_move_ability = unit.unit_res.move_ability
	#if bc.ability_options.has("cell"):
		#var path = bc.grid_navigation.find_path(unit.cell, bc.ability_options.get("cell"))
		#var ability_command = unit_move_ability.command.new(unit, path)
		#print(ability_command)
		#CommandController.add(ability_command)
		#bc.ability_options.clear()
	#for input_step in unit_move_ability.input_steps:
		#var state = bc.input_state
		#state.setup_ability(unit, unit_move_ability, input_step)
		#push_state(state)
	#print(unit.unit_res.move_ability.input_steps[0])
	#push_state(unit.unit_res.move_ability.input_steps[0].input_state)

func exit():
	unit.deselect()
	super()
	#EventBus.unit_deselected.emit()
	#unit.deselected()

func handle_cursor_click(cell: Vector2i):
	pass
	#pop_state()
	#super(cell)

func handle_cursor_move(cell: Vector2i):
	#print("SelectState handle_cursor_move")
	if unit.cell == cell:
		return
	super(cell)
