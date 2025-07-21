extends Node

@export var unit_scene: PackedScene

var gameplay_node
var current_room_instance
	
func load_gameplay_node(_gameplay_node):
	gameplay_node = _gameplay_node
	setup_units() # temp temp !!!
	setup_room()
	
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

func setup_room():
	var room = MissionController.current_mission.spawn_room
	current_room_instance = room.instantiate()
	gameplay_node.room_container.add_child(current_room_instance)
	print("entrance_cell", current_room_instance.entrance_cell)
	print("exit_cell", current_room_instance.exit_cell)
	print("ally_spawn_cells", current_room_instance.ally_spawn_cells)
	print("enemy_spawn_cells", current_room_instance.enemy_spawn_cells)
	
