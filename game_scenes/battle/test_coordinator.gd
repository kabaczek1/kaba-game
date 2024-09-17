extends Node

@export var main_grid: MainGrid
@export var offset_grid: OffsetGrid
@export var grid_path: GridPath
@export var grid_navigation: GridNavigation

@export var origin_cell: Vector2i = Vector2i(3,3)
@export var target_cell: Vector2i = Vector2i(6,9)

func _ready() -> void:
	assert(main_grid != null, "set main_grid")
	assert(offset_grid != null, "set offset_grid")
	assert(grid_path != null, "set grid_path")
	assert(grid_navigation != null, "set grid_navigation")

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

func update_grid_path():
	grid_path.cells_array = grid_navigation.find_path(origin_cell, target_cell)
