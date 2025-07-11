extends Resource

class_name Mission

@export var icon: Texture
@export var name: String = "Mission"
@export var description: String = "Mission Description"
@export var world_map_cell: Vector2i = Vector2i(2,2)
@export_enum("completed", "available", "unavailable") var status: int = 2

@export var spawn_room: Room
