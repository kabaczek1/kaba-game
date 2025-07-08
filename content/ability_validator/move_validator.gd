extends Validator

func validate(origin:Vector2i, target:Vector2i) -> bool:
	print(BattleController.level.level_cells[target])
	return true
