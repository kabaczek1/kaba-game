extends TileMapLayer

class_name MainGrid

func position_to_grid(v: Vector2) -> Vector2i:
	var local_position = to_local(v)
	return local_to_map(local_position)

func grid_to_position(v: Vector2i) -> Vector2:
	var snapped_local_position = map_to_local(v)
	var snapped_global_position = to_global(snapped_local_position)
	return snapped_global_position

func snapped_position(v: Vector2) -> Vector2:
	return grid_to_position(position_to_grid(v))
