extends Command

class_name MoveCommand

var original_move_array: Array[Vector2i]
var original_remaining_speed: int

func _init(unit: GridUnit, move_array: Array[Vector2i]) -> void:
	super(unit, move_array)

func execute():
	print("MoveCommand - execute")
	original_move_array = target
	original_remaining_speed = source.remaining_speed
	print("Saving", str(original_move_array))
	print("Move Unit", str(source), " on path ", str(target))
	source.move(target.duplicate())

func undo():
	print("MoveCommand - undo")
	print("original_move_array", str(original_move_array))
	original_move_array.reverse()
	print("original_move_array", str(original_move_array))
	print("Move Unit", str(source), " on path ", str(original_move_array))
	source.move(original_move_array.duplicate())
	source.remaining_speed = original_remaining_speed
	EventBus.move_undid.emit()
