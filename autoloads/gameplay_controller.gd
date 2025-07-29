extends Node

@export var unit_scene: PackedScene

var gameplay_node: Node2D
var current_room_scene: PackedScene
var current_room_instance: Room

var ally_units: Array[Unit]
var enemy_units: Array[Unit]
var gamestate: Dictionary[Vector2i, Tile]
var all_grid_cells: Array[Vector2i]
	
func end_mission_gameplay():
	# possible animation?
	MissionController.complete_mission()
	SceneController.go_to_mission_summary()
	
	
func load_gameplay_node(_gameplay_node):
	gameplay_node = _gameplay_node
	mount_spawn_room()
	
func prep_room(room: PackedScene):
	current_room_scene = room
	load_room()
	setup_gamestate()
	spawn_allies()
	spawn_enemies()
	
func load_room():
	current_room_instance = current_room_scene.instantiate()
	gameplay_node.room_container.add_child(current_room_instance)
	
func mount_spawn_room():
	prep_room(MissionController.current_mission.spawn_room)
	
func mount_next_room():
	clear_containers()
	prep_room(current_room_instance.next_room)
	
func clear_containers():
	for n in gameplay_node.room_container.get_children():
		n.queue_free()
		
	for n in gameplay_node.unit_container.get_children():
		n.queue_free()
		
	gamestate.clear()
	
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
		var unit = unit_scene.instantiate()
		unit.character = character
		unit.cell = spawn_points[i]
		unit.setup()
		units_array.append(unit)
		gameplay_node.unit_container.add_child(unit)
		gamestate[unit.cell].unit = unit
		i+=1
	
	return units_array
	
func spawn_allies():
	ally_units = spawn_units(GlobalController.team, current_room_instance.ally_spawn_cells)

func spawn_enemies():
	ally_units = spawn_units(current_room_instance.enemies, current_room_instance.enemy_spawn_cells)

#region cell<->position
func cell_to_position(cell: Vector2i):
	return gameplay_node.main_grid.cell_to_position(cell)

func position_to_cell(position: Vector2):
	return gameplay_node.main_grid.position_to_cell(position)
#endregion


#region gamestate

func get_unit_by_cell(cell):
	return gamestate[cell].unit


#endregion
