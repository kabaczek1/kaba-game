extends Node2D

@export var layer_offset: Vector2 = Vector2(16, 16)
@export var cells: Array[Vector2i]

@onready var main_layer: TileMapLayer = $MainLayer
@onready var offset_layer: TileMapLayer = $OffsetLayer

var flip_h := TileSetAtlasSource.TRANSFORM_FLIP_H
var flip_v := TileSetAtlasSource.TRANSFORM_FLIP_V
var transpose := TileSetAtlasSource.TRANSFORM_TRANSPOSE

var tile_array = [
	[Vector2i(0,0), 0],
	[Vector2i(1,0), flip_v + flip_h],
	[Vector2i(1,0), flip_v],
	[Vector2i(2,0), flip_v + transpose],
	[Vector2i(1,0), flip_h],
	[Vector2i(2,0), flip_h],
	[Vector2i(3,0), flip_h],
	[Vector2i(4,0), flip_v + flip_h],
	[Vector2i(1,0), 0],
	[Vector2i(3,0), 0],
	[Vector2i(2,0), 0],
	[Vector2i(4,0), flip_v],
	[Vector2i(2,0), transpose],
	[Vector2i(4,0), flip_h],
	[Vector2i(4,0), 0],
	[Vector2i(5,0), 0]
]

func _ready() -> void:
	offset_layer.position += layer_offset
	cells = main_layer.get_used_cells()
	update_grid()

func update_grid():
	for main_cell in cells:
		var offset_cells: Array[Vector2i] = get_offset_cells(main_cell)
		for offset_cell in offset_cells:
			var offset_cell_main_neighbours: Array[Vector2i] = get_main_cells(offset_cell)
			var neighbour_matrix = get_neighbour_matrix(cells, offset_cell_main_neighbours)
			set_offset_layer_cell(offset_cell, neighbour_matrix)

func set_offset_layer_cell(offset_cell: Vector2i, neighbour_matrix: int):
	var dict_value = tile_array[neighbour_matrix]
	var current_tile_atlas_coords: Vector2i = dict_value[0]
	var transforms: int = dict_value[1]
	offset_layer.set_cell(offset_cell, 0, current_tile_atlas_coords, transforms)

func get_neighbour_matrix(
	all_used_cells: Array[Vector2i],
	offset_cell_main_neighbours: Array[Vector2i]
) -> int:
	var output = 0
	if offset_cell_main_neighbours[0] in all_used_cells:
		output += 8
	if offset_cell_main_neighbours[1] in all_used_cells:
		output += 4
	if offset_cell_main_neighbours[2] in all_used_cells:
		output += 2
	if offset_cell_main_neighbours[3] in all_used_cells:
		output += 1
	return output

func get_offset_cells(main_cell: Vector2i) -> Array[Vector2i]:
	return get_cells(main_cell, Vector2i(-1,-1), Vector2i(0,-1), Vector2i(0,0), Vector2i(-1,0))

func get_main_cells(offset_cell: Vector2i) -> Array[Vector2i]:
	return get_cells(offset_cell, Vector2i(0,0), Vector2i(1,0), Vector2i(0,1), Vector2i(1,1))

func get_cells(
	cell: Vector2i,
	left_upper: Vector2i,
	right_upper: Vector2i,
	left_lower: Vector2i,
	right_lower: Vector2i
) -> Array[Vector2i]:
	var left_upper_cell = cell + left_upper
	var right_upper_cell = cell + right_upper
	var left_lower_cell = cell + left_lower
	var right_lower_cell = cell + right_lower
	return [
		left_upper_cell,
		right_upper_cell,
		left_lower_cell,
		right_lower_cell
	]
