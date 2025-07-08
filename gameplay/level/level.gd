extends Node2D

class_name Level

@export var level_resource: LevelResource
@onready var placeholders: TileMapLayer = $Placeholders

var level_cells: Dictionary[Vector2i, Enums.LevelTargetType]

func setup(_level_resource):
	level_resource = _level_resource
	print(BattleController.get_all_grid_cells())
	for cell in BattleController.get_all_grid_cells():
		print(cell)
		var data: TileData = placeholders.get_cell_tile_data(cell)
		print(data)
		if data:
			level_cells.set(cell, data.get_custom_data("LevelTargetType"))

func get_ground_tiles():
	var output: Array[Vector2i] = []
	for cell in level_cells:
		if level_cells[cell] == Enums.LevelTargetType.GROUND:
			output.append(cell)
	return output
