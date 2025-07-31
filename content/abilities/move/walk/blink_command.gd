extends Command

func _init(_unit, _target) -> void:
	super(_unit, _target)

func execute():
	unit.moved = true
	GameplayController.change_unit_gamestate_cell(unit, target)
	unit.position = GameplayController.cell_to_position(target)
	unit.cell = target
	
