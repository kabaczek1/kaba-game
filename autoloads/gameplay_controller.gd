extends Node

@export var unit_scene: PackedScene

var gameplay_node
var current_room_instance
var ally_units: Array[Unit]
var enemy_units: Array[Unit]
var gamestate: Dictionary[Vector2i, Tile]
var all_grid_cells: Array[Vector2i]
	
func load_gameplay_node(_gameplay_node):
	gameplay_node = _gameplay_node
	var room = MissionController.current_mission.spawn_room
	#setup_units() # temp temp !!!
	load_room(room)
	setup_gamestate()
	spawn_allies()
	
func cell_to_position(cell: Vector2i):
	return gameplay_node.main_grid.cell_to_position(cell)

func position_to_cell(position: Vector2):
	return gameplay_node.main_grid.position_to_cell(position)

func setup_units():
	var i = 0
	for character in GlobalController.team:
		var unit = unit_scene.instantiate()
		unit.character = character
		unit.cell = Vector2i(1+i,1+i)
		unit.setup()
		gameplay_node.unit_container.add_child(unit)
		i+=1

func load_room(room):
	for n in gameplay_node.room_container.get_children():
		n.queue_free()
	
	current_room_instance = room.instantiate()
	gameplay_node.room_container.add_child(current_room_instance)
	
func setup_gamestate():
	for cell in get_all_grid_cells():
		var tile_type = current_room_instance.layout.get_cell_tile_data(cell).get_custom_data("type")
		var tile = Tile.new(tile_type)
		gamestate[cell] = tile
	
func get_all_grid_cells() -> Array[Vector2i]:
	if all_grid_cells != []:
		return all_grid_cells
	var grid_end = gameplay_node.main_grid.grid_region.end
	for i in range(grid_end.x):
		for j in range(grid_end.y):
			all_grid_cells.append(Vector2i(i,j))
	return all_grid_cells
	
func spawn_units(characters: Array[Character], spawn_points: Array[Vector2i]):
	var i = 0
	var units_array: Array[Unit] = []
	for character in characters:
		print(character.name)
		var unit = unit_scene.instantiate()
		unit.character = character
		unit.cell = spawn_points[i]
		unit.setup()
		units_array.append(unit)
		gameplay_node.unit_container.add_child(unit)
		gamestate[unit.cell].unit = unit
		print(gamestate[unit.cell].type, gamestate[unit.cell].unit)
		i+=1
	
	return units_array
	
func spawn_allies():
	ally_units = spawn_units(GlobalController.team, current_room_instance.ally_spawn_cells)
