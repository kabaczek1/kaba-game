extends Node

class_name PlayerInputController



func _ready() -> void:
	EventBus.cursor_cell_clicked.connect(handle_cursor_cell_clicked)
	EventBus.cursor_cell_changed.connect(handle_cursor_cell_changed)

func handle_cursor_cell_clicked(cell):
	print("handle_cursor_cell_clicked", cell)
	print(GameplayController.gamestate[cell].info())
	GameplayController.select_unit_by_cell(cell)

func handle_cursor_cell_changed(cell):
	print("handle_cursor_cell_changed", cell)


#unit > character > move ability:
# reach
# reach_validator
# target_validator
# 
