extends TileMapLayer

class_name MainGrid

@export var grid_region: Rect2i = Rect2i(0, 0, 19, 9)

func _ready() -> void:
	assert(grid_region != null, "Set grid_region")

func position_to_grid(v: Vector2) -> Vector2i:
	var local_position = to_local(v)
	return local_to_map(local_position)

func grid_to_position(v: Vector2i) -> Vector2:
	var snapped_local_position = map_to_local(v)
	var snapped_global_position = to_global(snapped_local_position)
	return snapped_global_position

func snapped_position(v: Vector2) -> Vector2:
	return grid_to_position(position_to_grid(v))

func is_on_the_grid(cell: Vector2i) -> bool:
	return grid_region.has_point(cell)

func get_shape_around_cell(size: int, origin_cell: Vector2i, shape: Enums.Shape) -> Array[Vector2i]:
	if shape == Enums.Shape.CIRCLE:
		return get_circle_around_cell(size, origin_cell)
	return []

func get_circle_around_cell(size: int, origin_cell: Vector2i) -> Array[Vector2i]:
	var output: Array[Vector2i] = []
	for cell in get_circle(size):
		output.append(cell + origin_cell)
	return output

func get_circle(size: int) -> Array[Vector2i]:
	var output: Array[Vector2i] = []
	output.append_array(get_line(Vector2i(0,0), size))
	for i in range(1, size + 1):
		output.append_array(get_line(Vector2i(0,-i), size - i))
		output.append_array(get_line(Vector2i(0,i), size - i))
	return output

func get_line(cell: Vector2i, size: int) -> Array[Vector2i]:
	#print("get_line() cell: ", cell, " size: ", size)
	var output: Array[Vector2i] = []
	output.append(cell)
	for i in range(1, size + 1):
		output.append(Vector2i(-i,0) + cell)
		output.append(Vector2i(i,0) + cell)
	return output
