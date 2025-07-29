extends IdleState

class_name AbilityState

var unit: Unit
var ability: Ability

func _init(_state_machine: StateMachine, _unit: Unit, _ability: Ability) -> void:
	super(_state_machine, "AbilityState")
	ability = _ability
	unit = _unit

func enter():
	EventBus.unit_selected.emit(unit)
	var ability_area: Array[Vector2i] = []
	ability_area = gc.gameplay_node.main_grid.get_circle_around_cell(ability.reach, unit.cell)
	var reach_validator = ability.reach_validator.new()
	ability_area = reach_validator.validate(unit.cell, ability_area)
	#var target_validator = ability.target_validator.new()
	#ability_area = ability.target_validator.validate(unit.cell, ability_area)
	
	gc.gameplay_node.area_indicator.clear_all_cells()
	gc.gameplay_node.area_indicator.fill_cells(ability_area)
	super()
	#if BattleController.bs.cursor.current_cell != unit.cell:
		#pop_state()
		#return
	#unit.glance_start()
	#BattleController.bs.cursor.highlight_cell()

func exit():
	EventBus.unit_deselected.emit(unit)
	super()
	#unit.glance_stop()
	#BattleController.bs.cursor.stop()

func handle_cursor_click(cell: Vector2i):
	print("Ability cursor_click : ", cell, " - ", gc.get_unit_by_cell(cell))

func handle_cursor_move(cell: Vector2i):
	print("Ability cursor_move : ", cell, " - ", gc.get_unit_by_cell(cell))
