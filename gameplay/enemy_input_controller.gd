extends Node

var gc = GameplayController

func _ready() -> void:
	EventBus.enemy_turn_started.connect(func():
		print("BUahahah >:(")
		
		process_enemies()
		
		var timer = get_tree().create_timer(3.0)
		timer.timeout.connect(func():
			GameplayController.end_enemy_turn()
		)
	)
	

func process_enemies():
	for unit in gc.enemy_units:
		var valid_targets = target_in_range(unit, unit.character.move_ability) # should be attack
		if valid_targets:
			move(unit, valid_targets) 
			print("attack after move")

func target_in_range(unit, ability):
	var ability_area = gc.gameplay_node.main_grid.get_circle_around_cell(ability.reach, unit.cell)
	var reach_validator = ability.reach_validator.new()
	ability_area = reach_validator.validate(unit.cell, ability_area)
	
	var target_validator = ability.target_validator.new()
	var target_area = target_validator.validate(unit.cell, ability_area)
	return target_area
	
func attack():
	pass

func move(unit, valid_targets): 
	# no running away, all in, all the time
	var cell = valid_targets.pick_random()
	var ability_command = unit.character.move_ability.command.new(unit, cell)
	gc.use_ability_command(ability_command)
