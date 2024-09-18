extends Node2D

class_name GridObject

#@export var main_grid: MainGrid
@export var cell: Vector2i

#func _ready() -> void:
	#assert(main_grid != null, "set main_grid")
