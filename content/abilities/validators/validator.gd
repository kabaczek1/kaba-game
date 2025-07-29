
class_name Validator

func validate(origin: Vector2i, area: Array[Vector2i]):
	var output: Array[Vector2i] = []
	for cell in area:
		if validate_cell(origin, cell):
			output.append(cell)
	return output

func validate_cell(_origin: Vector2i, _target: Vector2i):
	return true
