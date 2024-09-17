extends TileMapLayer

@onready var offset_layer: TileMapLayer = $"../ObstacleLayer"
@onready var grid_path: Node2D = $"../GridPath"
@onready var navigation: Node = $"../Navigation"

@export var origin_cell: Vector2i = Vector2i(3,3)
@export var target_cell: Vector2i = Vector2i(6,9)

func _input(event):
	if event is InputEventMouseButton and event.get_button_index() == 1 and event.pressed == true:
		target_cell = position_to_grid(event.position)
		var new_cells_array = navigation.find_path(origin_cell, target_cell)
		grid_path.cells_array = new_cells_array
	if event is InputEventMouseButton and event.get_button_index() == 2 and event.pressed == true:
		origin_cell = position_to_grid(event.position)
		var new_cells_array = navigation.find_path(origin_cell, target_cell)
		grid_path.cells_array = new_cells_array
	if event is InputEventMouseButton and event.get_button_index() == 3 and event.pressed == true:
		offset_layer.add_cell(position_to_grid(event.position))

func position_to_grid(v: Vector2) -> Vector2i:
	var local_position = to_local(v)
	return local_to_map(local_position)

func grid_to_position(v: Vector2i) -> Vector2:
	var snapped_local_position = map_to_local(v)
	var snapped_global_position = to_global(snapped_local_position)
	return snapped_global_position

func snapped_position(v: Vector2) -> Vector2:
	return grid_to_position(position_to_grid(v))
