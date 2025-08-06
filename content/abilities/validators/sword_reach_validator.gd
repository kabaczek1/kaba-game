extends Validator

func validate_cell(_origin: Vector2i, target: Vector2i):
	if GameplayController.gamestate[target].unit != null:
		return true
	return false
