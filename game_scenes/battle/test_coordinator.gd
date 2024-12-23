extends Node

@export var main_grid: MainGrid
@export var offset_grid: OffsetGrid
@export var grid_path: GridPath
@export var grid_navigation: GridNavigation
@export var team_controller: TeamController
@export var cursor: Cursor

@export var origin_cell: Vector2i = Vector2i(4,4)
@export var target_cell: Vector2i = Vector2i(6,8)

var current_grid_path

func _ready() -> void:
	assert(main_grid != null, "set main_grid")
	assert(offset_grid != null, "set offset_grid")
	assert(grid_path != null, "set grid_path")
	assert(grid_navigation != null, "set grid_navigation")
	var current_grid_path = grid_path

func _input(event):
	if event is InputEventMouseButton and event.pressed == true:
		if event.get_button_index() == 1:
			target_cell = main_grid.position_to_grid(event.position)
			update_grid_path()
		if event.get_button_index() == 2:
			origin_cell = main_grid.position_to_grid(event.position)
			update_grid_path()
		if event.get_button_index() == 3:
			offset_grid.flip_cell(main_grid.position_to_grid(event.position))
			update_grid_path()
	#if event is InputEventMouseMotion:
		#target_cell = cursor.current_cell
		#if team_controller.can_move_to_cell(origin_cell, target_cell, 3):
			#update_grid_path()
			#grid_path.show()
			#grid_path2.show()
		#else:
			#grid_path.hide()
			#grid_path2.hide()

func update_grid_path():
	var nav_cells = grid_navigation.find_path(origin_cell, target_cell)
	grid_path.cells_array = nav_cells
	team_controller.setup_units()
