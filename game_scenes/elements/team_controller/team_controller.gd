extends Node

class_name TeamController

@export var main_grid: MainGrid
@export var range_grid: OffsetGrid
@export var obstacle_grid: OffsetGrid
@export var grid_path: GridPath
@export var grid_navigation: GridNavigation
@export var team_id: int = 0

var units: Array[Node]

func _ready() -> void:
	setup_units()

func setup_units():
	range_grid.clear_cells()
	units = get_children()
	for unit in units:
		unit.position = main_grid.grid_to_position(unit.cell)
		show_move_range(unit.cell, unit.speed)
	range_grid.update_grid()

func show_move_range(cell: Vector2i, speed: int):
	range_grid.cells.append_array(get_move_array(cell, speed))

func get_move_array(cell: Vector2i, speed: int) -> Array[Vector2i]:
	var all_cells: Array[Vector2i] = []
	#get basic shape
	for i in range(1, speed + 1):
		var new_range = range(1, speed - i + 1)
		all_cells.append(cell + Vector2i(i,0))
		for j in new_range:
			all_cells.append(cell + Vector2i(i,j))
			all_cells.append(cell + Vector2i(i,-j))
		all_cells.append(cell + Vector2i(-i,0))
		for j in new_range:
			all_cells.append(cell + Vector2i(-i,-j))
			all_cells.append(cell + Vector2i(-i,j))
		all_cells.append(cell + Vector2i(0,i))
		all_cells.append(cell + Vector2i(0,-i))
	#process
	var output: Array[Vector2i] = [] 
	for i in all_cells:
		if can_move_to_cell(cell, i, speed):
			output.append(i)
	output.append(cell)
	return output

func can_move_to_cell(origin: Vector2i, target: Vector2i, speed: int) -> bool:
	if not(main_grid.is_on_the_grid(target)):
		return false
	if obstacle_grid.cells.has(target):
		return false
	for unit in units:
		if unit.cell == target:
			return false
	var path = grid_navigation.find_path(origin, target)
	if path == []:
		return false
	if path.size() > speed + 1:
		return false
	return true
