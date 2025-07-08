extends Command

class_name MoveCommand

var original_move_array: Array[Vector2i]

func _init(_unit: GridUnit, _ability_options: Dictionary[String, Variant]) -> void:
	super(_unit, _ability_options)

func execute():
	print("MoveCommand - execute")
	print(unit.unit_res.name)
	print(ability_options)
	var ability = unit.unit_res.move_ability
	if ability.input_steps.is_empty():
		return
	var input_step = ability.input_steps[0]
	var initial_cells = BattleController.bs.main_grid.get_shape_around_cell(ability.grid_range, unit.cell, input_step.shape)
	var available_cells:Array[Vector2i] = []
	var level_cells = BattleController.level.get_ground_tiles()
	print(level_cells)
	for cell in initial_cells:
		if BattleController.bs.grid_navigation.find_path(unit.cell, ability_options.get("cell"), level_cells).size() <= ability.grid_range:
			available_cells.append(cell)
	
	var path = BattleController.bs.grid_navigation.find_path(unit.cell, ability_options.get("cell"), available_cells)
	unit.move(path)
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
