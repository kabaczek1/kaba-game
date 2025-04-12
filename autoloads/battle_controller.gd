extends Node

# config
@export var grid_unit_scene: PackedScene


#temp
@export var enemy_unit_res: UnitResource

#var main_grid: MainGrid
#var range_grid: OffsetGrid
#var obstacle_grid: OffsetGrid
#var grid_path: GridPath
#var grid_navigation: GridNavigation

#var cursor: Cursor
#var info_box: InfoBox
#var level_container: Node2D

var all_grid_cells: Array[Vector2i]

var level: Level
var bs: BattleScene #battle_scene

var units: Dictionary[Vector2i, GridUnit]

var current_turn: int
var current_turn_team: Enums.Team

func _ready() -> void:
	EventBus.battle_scene_loaded.connect(on_battle_scene_loaded)
	EventBus.player_turn_ended.connect(on_player_turn_ended)
	EventBus.player_turn_started.connect(on_player_turn_started)

func on_player_turn_ended():
	
	for unit in get_all_units():
		unit.deselect()
		if unit.team == Enums.Team.ENEMY:
			unit.new_turn()
	print("enemy AI")
	await bs.info_box.display("enemy turn")
	current_turn += 1
	EventBus.player_turn_started.emit()

func on_player_turn_started():
	for unit in get_all_units():
		unit.deselect()
		if unit.team == Enums.Team.PLAYER:
			unit.new_turn()
	await bs.info_box.display("player turn")


#region setup
func on_battle_scene_loaded(current_battle_scene):
	bs = current_battle_scene
	setup_new_battle()

func setup_new_battle():
	print("setup_new_battle")
	current_turn = 1
	print(RunController.team)
	print(RunController.level)
	setup_level()
	setup_teams()
	update_unit_dictionary()

func setup_teams():
	var player_team = TeamController.new("PlayerTeam", true, Enums.Team.PLAYER, "PLAYER TURN")
	player_team.name = "PlayerTeam"
	bs.teams_container.add_child(player_team)
	setup_player_units(player_team)
	var enemy_team = TeamController.new("EnemyTeam", false, Enums.Team.ENEMY, "ENEMY TURN")
	enemy_team.name = "EnemyTeam"
	bs.teams_container.add_child(enemy_team)
	setup_enemy_units(enemy_team)

func setup_player_units(tc: TeamController):
	var x = 1
	for unit_resource in RunController.team:
		var unit = grid_unit_scene.instantiate()
		unit.setup(unit_resource, Enums.Team.PLAYER, Vector2i(3, 2 + x))
		x += 1
		tc.add_child(unit)

func setup_enemy_units(tc: TeamController):
	for i in range(RunController.level.difficulty):
		var unit = grid_unit_scene.instantiate()
		unit.setup(enemy_unit_res, Enums.Team.PLAYER, Vector2i(14, 2 + i))
		tc.add_child(unit)

func setup_level():
	level = RunController.level.level_scene.instantiate()
	bs.level_container.add_child(level)
	level.setup(RunController.level)
	
	#temp
	var level_cells = level.level_cells
	for key in level_cells:
		print(key, " - ", level_cells[key])
		if level_cells[key] == Enums.LevelTargetType.OBSTACLE:
			bs.obstacle_grid.cells.append(key)
			bs.obstacle_grid.redraw()

#endregion

#func process_turn():
	#for team in teams:
		#if team.player_controlled:
			#info_box.display(team.start_turn_message)
			#await EventBus.info_box_animation_finished
			#EventBus.player_turn_started.emit()
		#if not(team.player_controlled):
			#info_box.display(team.start_turn_message)
			#await EventBus.info_box_animation_finished
			#print("AI turn")

#region units
func get_teams():
	return bs.teams_container.get_children()

func update_unit_dictionary():
	var units_array: Array[GridUnit] = []
	units.clear()
	for team in get_teams():
		units_array.append_array(team.get_units())
	for unit in units_array:
		units.set(unit.cell, unit)

func get_all_units() -> Array[GridUnit]:
	return units.values()

func get_all_unit_cells() -> Array[Vector2i]:
	return units.keys()

func get_unit_by_cell(cell: Vector2i):
	if units.has(cell):
		return units.get(cell)
	return null

func remove_unit_from_unit_dictionary(unit: GridUnit):
	units.erase(unit.cell)
#endregion

#region grid
func position_to_cell(position: Vector2) -> Vector2i:
	return bs.main_grid.position_to_grid(position)

func cell_to_position(cell: Vector2i) -> Vector2:
	return bs.main_grid.grid_to_position(cell)

func get_all_grid_cells() -> Array[Vector2i]:
	if all_grid_cells != []:
		return all_grid_cells
	var output: Array[Vector2i] = []
	var grid_end = bs.main_grid.grid_region.end
	for i in range(grid_end.x):
		for j in range(grid_end.y):
			all_grid_cells.append(Vector2i(i,j))
	return all_grid_cells

#endregion
