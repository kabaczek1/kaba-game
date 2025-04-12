extends Command

class_name BlinkCommand

var original_move_array: Array[Vector2i]

func _init(_unit: GridUnit, _ability_options: Dictionary[String, Variant]) -> void:
	super(_unit, _ability_options)

func execute():
	print("BlinkCommand - execute")
	print(unit.unit_res.name)
	print(ability_options)
	var ability = unit.unit_res.move_ability
	if ability.input_steps.is_empty():
		return
	var input_step = ability.input_steps[0]
	var available_cells = BattleController.bs.main_grid.get_shape_around_cell(ability.grid_range, unit.cell, input_step.shape)
	unit.cell = ability_options.get("cell")
	unit.position = BattleController.cell_to_position(unit.cell)
	unit.moved = true
	BattleController.update_unit_dictionary()
	#original_move_array = target
	#print("Saving", str(original_move_array))
	#print("Move Unit", str(source), " on path ", str(target))
	#source.move(target.duplicate())

func undo():
	print("MoveCommand - undo")
	#print("original_move_array", str(original_move_array))
	#original_move_array.reverse()
	#print("original_move_array", str(original_move_array))
	#print("Move Unit", str(source), " on path ", str(original_move_array))
	#source.move(original_move_array.duplicate())
	#EventBus.move_undid.emit()
