extends Node


@export var obstacle_layer: TileMapLayer
@export var astar_grid_region: Rect2i = Rect2i(0, 0, 19, 9)

var obstacles: Array[Vector2i]
var astar_grid: AStarGrid2D

func _ready() -> void:
	astar_grid = AStarGrid2D.new()
	astar_grid.region = astar_grid_region
	astar_grid.cell_size = Vector2(32, 32)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.update()


func find_path(origin: Vector2i, target: Vector2i) -> Array[Vector2i]:
	for cell in obstacle_layer.cells:
		print(cell)
		astar_grid.set_point_solid(cell)
	var id_path = astar_grid.get_id_path(origin, target)
	print(id_path)
	return id_path
