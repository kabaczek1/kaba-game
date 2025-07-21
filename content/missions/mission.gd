extends Resource

class_name Mission

@export var icon: Texture
@export var name: String = "Mission"
@export var description: String = "Mission Description"
@export var world_map_cell: Vector2i = Vector2i(2,2)
@export_enum("completed", "available", "unavailable") var status: int = 2
@export var item_pool: Array[Item]
@export var item_available: bool = false
@export var spawn_room: PackedScene
@export var next_mission: Mission

func complete_mission():
	item_available = true
	status = 0
	
func collect_reward():
	item_available = false
	
func is_completed():
	return status == 0
	
func is_available():
	return status == 1
	
func is_unavailable():
	return status == 2
	
func make_available():
	status = 1
