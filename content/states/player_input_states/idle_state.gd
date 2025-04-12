extends State

class_name IdleState

var bc = BattleController

func _init(_state_machine: StateMachine, _name: String = "IdleState") -> void:
	super(_state_machine, _name)

func enter():
	super()

func exit():
	super()

func handle_cursor_click(cell: Vector2i):
	#print("IDLE cursor_click : ", cell, " - ", bc.get_unit_by_cell(cell))
	if bc.bs.cursor.current_cell != cell:
		bc.bs.cursor.move_cursor_to_cell(cell)
	var unit_in_cell = bc.get_unit_by_cell(cell)
	if unit_in_cell != null:
		push_state(SelectState.new(state_machine, unit_in_cell))

func handle_cursor_move(cell: Vector2i):
	#print("IDLE cursor_move  : ", cell, " - ", bc.get_unit_by_cell(cell))
	var unit_in_cell = bc.get_unit_by_cell(cell)
	if unit_in_cell != null:
		push_state(HoverState.new(state_machine, unit_in_cell))
