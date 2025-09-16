extends Validator

func validate_cell(_origin: Vector2i, target: Vector2i):
	if GameplayController.gamestate[target].type != Enums.RoomTargetType.OBSTACLE:
		return true
	return false
