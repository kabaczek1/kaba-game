extends IdleState

class_name HoverState

var unit: Unit

func _init(_state_machine: StateMachine, _unit: Unit) -> void:
	super(_state_machine, "HoverState")
	unit = _unit

func enter():
	EventBus.unit_hover_started.emit(unit)
	super()
	#if BattleController.bs.cursor.current_cell != unit.cell:
		#pop_state()
		#return
	#unit.glance_start()
	#BattleController.bs.cursor.highlight_cell()

func exit():
	EventBus.unit_hover_stopped.emit(unit)
	super()
	#unit.glance_stop()
	#BattleController.bs.cursor.stop()

func handle_cursor_click(_cell: Vector2i):
	reset_and_set_state(SelectState.new(state_machine, unit))

func handle_cursor_move(cell: Vector2i):
	pop_state()
	super(cell)
