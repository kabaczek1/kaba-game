extends Node

@export var spawn_cells: Array[Vector2i]
@export var unit_scene: PackedScene
var gameplay_node
	
func load_gameplay_node(_gameplay_node):
	gameplay_node = _gameplay_node
	print(gameplay_node.main_grid)
	setup_units() # temp temp !!!
	
func cell_to_position(cell: Vector2i):
	return gameplay_node.main_grid.cell_to_position(cell)
	
func setup_units():
	var i = 0
	for character in GlobalController.team:
		var unit = unit_scene.instantiate()
		unit.character = character
		unit.cell = Vector2i(1+i,1+i)
		unit.setup()
		gameplay_node.unit_container.add_child(unit)
		i+=1
		
#func setup_grid():
	## spawn units
	#for character in GlobalController.team:
		
