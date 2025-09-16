extends Validator

func validate_cell(_origin: Vector2i, target: Vector2i):
	var target_unit = GameplayController.gamestate[target].unit
	if target_unit != null and not(target_unit.is_ally()):
		return true
	return false
