extends Command

func _init(_unit, _target) -> void:
	super(_unit, _target)

func execute():
	unit.moved = true
	unit.used_ability = true
	var target_unit = GameplayController.get_unit_by_cell(target)
	print(target_unit)
