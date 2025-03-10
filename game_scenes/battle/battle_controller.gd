@tool
extends Node

class_name BattleController

@export var main_grid: MainGrid
@export var range_grid: OffsetGrid
@export var obstacle_grid: OffsetGrid
@export var grid_path: GridPath
@export var grid_navigation: GridNavigation
@export var player_team: TeamController
@export var enemy_team: TeamController
@export var cursor: Cursor

var current_turn = 1

var current_unit
var unit_below_cursor
var current_unit_selected = false
var valid_move_target

var hover_move_range = false

func _ready() -> void:
	if Engine.is_editor_hint():
		assert_correct_dependencies()
	EventBus.cursor_cell_changed.connect(_on_cursor_cell_changed)
	EventBus.cursor_over_unit.connect(_on_cursor_over_unit)
	EventBus.cursor_left_main_grid.connect(_on_cursor_left_main_grid)
	EventBus.unit_cell_changed.connect(_on_unit_cell_changed)
	EventBus.player_turn_ended.connect(_on_player_turn_ended)
	EventBus.unit_movement_animation_ended.connect(_on_unit_movement_animation_ended)
	EventBus.move_undid.connect(_on_move_undid)
	update_obstacle_grid()

func _on_player_turn_ended():
	deselect_current_unit()
	clear_move_range()
	current_unit_selected = false
	valid_move_target = null
	current_unit = null
	#Enemy Actions
	for player_unit in player_team.units:
		player_unit.new_turn()
	for enemy_unit in enemy_team.units:
		enemy_unit.new_turn()
	current_turn += 1
	EventBus.turn_number_changed.emit(current_turn)

func _on_unit_movement_animation_ended(unit: GridUnit):
	if unit.can_move and unit == current_unit:
		show_move_range(unit.cell, unit.remaining_speed)

func _on_unit_cell_changed(unit: GridUnit):
	update_obstacle_grid()
	if valid_move_target == unit.cell:
		valid_move_target = null
	#show_move_range(unit.cell, unit.remaining_speed)

func _on_cursor_left_main_grid():
	grid_path.clear_path()
	valid_move_target = null

func _on_cursor_over_unit(unit: GridUnit):
	unit_below_cursor = unit

func _on_cursor_cell_changed(new_cell):
	#print(new_cell)
	if current_unit_selected\
	and current_unit.can_move\
	and not(current_unit.movement_animation_active):
		if can_move_to_cell(current_unit.cell, new_cell, current_unit.remaining_speed):
			update_grid_path(current_unit.cell, new_cell)
			valid_move_target = new_cell
		else:
			grid_path.clear_path()
			valid_move_target = null

func _on_move_undid():
	clear_move_range()

func assert_correct_dependencies():
	assert(main_grid != null, "set main_grid")
	assert(range_grid != null, "set range_grid")
	assert(obstacle_grid != null, "set obstacle_grid")
	assert(grid_path != null, "set grid_path")
	assert(grid_navigation != null, "set grid_navigation")
	assert(player_team != null, "set player_team")
	assert(enemy_team != null, "set enemy_team")
	assert(cursor != null, "set cursor")

func _input(event):
	if event is InputEventMouseButton and event.pressed == true:
		if event.get_button_index() == 1: # left
			handle_left_click()
		if event.get_button_index() == 2: # right
			handle_right_click()
		if event.get_button_index() == 3: # middle
			print("middle")

func handle_left_click():
	if unit_below_cursor != null and unit_below_cursor.cell == cursor.current_cell:
		select_current_unit()
		return
	if current_unit_selected == true\
	and valid_move_target != null\
	and current_unit.can_move\
	and not(current_unit.movement_animation_active):
		var moveCommand = MoveCommand.new(current_unit, grid_path.cells_array)
		CommandController.add(moveCommand)
		#current_unit.move(grid_path.cells_array)
		grid_path.clear_path()
		clear_move_range()
		return
	if cursor.on_the_main_grid:
		deselect_current_unit()

func handle_right_click():
	if current_unit_selected == true:
		deselect_current_unit()
		return

func select_current_unit():
	if current_unit_selected:
		if current_unit != null:
			deselect_current_unit()
	print("select_current_unit()")
	current_unit_selected = true
	current_unit = unit_below_cursor
	current_unit.is_selected = true
	cursor.stop()
	EventBus.unit_selected.emit(current_unit)
	if current_unit.can_move:
		show_move_range(current_unit.cell, current_unit.remaining_speed)

func deselect_current_unit():
	print("deselect_current_unit()")
	current_unit_selected = false
	valid_move_target = null
	if current_unit != null:
		current_unit.is_selected = false
		if current_unit.cell == cursor.current_cell:
			cursor.play("default")
	clear_move_range()
	EventBus.unit_deselected.emit()
	grid_path.clear_path()

func clear_move_range():
	range_grid.clear_all_cells()
	range_grid.redraw()

func show_move_range(cell: Vector2i, speed: int):
	if speed <= 0:
		return
	range_grid.clear_all_cells()
	range_grid.cells.append_array(get_move_array(cell, speed))
	range_grid.redraw()
	_on_cursor_cell_changed(cursor.current_cell)

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
	for unit in player_team.units:
		if unit.cell == target:
			return false
	for unit in enemy_team.units:
		if unit.cell == target:
			return false
	var path = grid_navigation.find_path(origin, target)
	if path == []:
		return false
	if path.size() > speed + 1:
		return false
	return true

func update_grid_path(origin_cell: Vector2i, target_cell: Vector2i):
	var nav_cells = grid_navigation.find_path(origin_cell, target_cell)
	grid_path.cells_array = nav_cells

func update_obstacle_grid():
	grid_navigation.obstacle_grid.cells.clear()
	for unit in player_team.units:
		grid_navigation.obstacle_grid.cells.append(unit.cell)
	for unit in enemy_team.units:
		grid_navigation.obstacle_grid.cells.append(unit.cell)
	grid_navigation.obstacle_grid.redraw()
	#TODO: fixup
