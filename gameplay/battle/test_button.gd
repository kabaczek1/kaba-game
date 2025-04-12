extends Button

@export var unit: GridUnit
@export var move_target: Vector2i

@export var command: GDScript

func _pressed():
	pass
	#print(command)
	#var ability_command = load(command.resource_path)
	#print(ability_command)
	#var ac = ability_command.new()
	#print(ac)
	#var instance = command.new(unit, path)
	#print(instance)
	#CommandController.add(instance)
	
	pass
	#var moveCommand = MoveCommand.new(unit, move_target)
	#CommandController.add(moveCommand)
