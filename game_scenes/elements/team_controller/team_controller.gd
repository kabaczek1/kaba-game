extends Node

class_name TeamController

@export var main_grid: MainGrid

var units: Array[Node]

func _ready() -> void:
	update_units_array()
	print(units)

func update_units_array():
	units = get_children()
	#for unit in units:
		#unit.position = main_grid.grid_to_position(unit.cell)
