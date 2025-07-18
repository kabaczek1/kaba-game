extends Resource

class_name Room

@export var enemies: Array[Character]
# enemy position/ dictionary, character + position ???
#@export var doors: Dictionary[Vector2i, Room]
#@export var door_cell: Dictionary[Vector2i, Room]
@export var next_room: Room
@export var room_scene: PackedScene
