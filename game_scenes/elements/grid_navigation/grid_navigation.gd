extends Node

class_name GridNavigation

@export var main_grid: MainGrid
@export var obstacle_grid: TileMapLayer

var astar_grid: AStarGrid2D

func _ready() -> void:
	assert(obstacle_grid != null, "set obstacle_grid")
	astar_grid = AStarGrid2D.new()
	astar_grid.region = main_grid.grid_region
	astar_grid.cell_size = Vector2(32, 32)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.update()

func find_path(origin: Vector2i, target: Vector2i) -> Array[Vector2i]:
	reset_astar_grid()
	for cell in obstacle_grid.cells:
		astar_grid.set_point_solid(cell)
	var id_path = astar_grid.get_id_path(origin, target)
	return id_path

func reset_astar_grid():
	astar_grid.clear()
	astar_grid.region = main_grid.grid_region
	astar_grid.update()
