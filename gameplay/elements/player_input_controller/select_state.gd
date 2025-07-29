extends IdleState

class_name SelectState

var unit: Unit

func _init(_state_machine: StateMachine, _unit: Unit) -> void:
	super(_state_machine, "SelectState")
	unit = _unit

func enter():
	EventBus.unit_selected.emit(unit)
	if not(unit.moved):
		push_state(AbilityState.new(state_machine, unit, unit.character.move_ability))
	super()


func exit():
	EventBus.unit_deselected.emit(unit)
	#unit.deselect()
	super()
	#EventBus.unit_deselected.emit()
	#unit.deselected()

func handle_cursor_click(cell: Vector2i):
	pop_state()
	super(cell)

func handle_cursor_move(cell: Vector2i):
	#print("SelectState handle_cursor_move")
	if unit.cell == cell:
		return
	super(cell)
