extends Resource

class_name Room

@export var enemies: Array[Character]
# enemy position/ dictionary, character + position ???
@export var doors: Dictionary[Vector2i, Room]
@export var room_scene: PackedScene
