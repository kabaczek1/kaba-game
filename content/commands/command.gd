extends Resource

class_name Command

var name: String
var can_undo: bool = false
var unit: GridUnit
var ability_options: Dictionary[String, Variant]

func _init(_unit, _ability_options) -> void:
	unit = _unit
	ability_options = _ability_options

func execute():
	pass

func undo():
	pass
