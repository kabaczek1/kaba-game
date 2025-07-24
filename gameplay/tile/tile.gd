class_name Tile

var unit: Unit
var type: Enums.RoomTargetType
#var effect
func _init(_type) -> void:
	type = _type

func info():
	var output = "Tile, "
	if unit:
		output += "unit: %s, " % [unit.character.name]
	output += "type: %s " % [type]
	return output
