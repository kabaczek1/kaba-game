extends Resource

class_name AbilityInputStep

@export var description: String
@export var option_key: String
@export var target: Enums.TargetType
@export var shape: Enums.Shape
@export var range: int
@export var cell_validator: Validator

func validate_cell(_cell):
	return true

func validate_option_target(_value):
	return true
