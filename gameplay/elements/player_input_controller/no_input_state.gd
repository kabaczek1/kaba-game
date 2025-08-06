extends IdleState

class_name NoInputState

func _init(_state_machine: StateMachine, _name: String = "NoInputState") -> void:
	super(_state_machine, _name)

func enter():
	super()

func exit():
	super()

func handle_cursor_click(cell: Vector2i):
	pass

func handle_cursor_move(cell: Vector2i):
	pass
