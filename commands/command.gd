class_name Command

var name: String
var can_undo: bool = true
var source
var target

func _init(src, tar) -> void:
	source = src
	target = tar

func execute():
	pass

func undo():
	pass
