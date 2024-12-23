extends Node2D

class_name GridPath

@export var tile_map: TileMapLayer
@export var texture: AtlasTexture

var cells_array: Array[Vector2i]:
	set(value):
		cells_array = value
		if cells_array.size() >= 2:
			draw_path()
		else:
			print("hmm")

var steps_array: Array[int] # 0 - up, 1 - right, 2 - down, 3 - left

#func _ready() -> void:
	#draw_path()

func draw_path():
	for n in get_children():
		remove_child(n)
	create_steps_array()
	spawn_path_elements()

const UP = 0
const RIGHT = 1
const DOWN = 2
const LEFT = 3

func create_steps_array():
	steps_array.clear()
	for i in cells_array.size() - 1:
		var cell = cells_array[i]
		var next = cells_array[i + 1]
		var direction: int
		if cell.x < next.x:
			direction = RIGHT
		if cell.x > next.x:
			direction = LEFT
		if cell.y < next.y:
			direction = DOWN
		if cell.y > next.y:
			direction = UP
		steps_array.append(direction)

const ORIGIN_SEGMENT = 0
const STRAIGHT_SEGMENT = 1
const TURN_SEGMENT = 2
const TARGET_SEGMENT = 3

func spawn_path_elements():
	spawn_path_element(cells_array[0], ORIGIN_SEGMENT, steps_array[0]*90)
	for i in range(1, cells_array.size() - 1):
		var segment
		if steps_array[i - 1] == steps_array[i]:
			segment = STRAIGHT_SEGMENT
		else:
			segment = TURN_SEGMENT
		var segment_rotation
		if segment == STRAIGHT_SEGMENT:
			segment_rotation = steps_array[i]*90
		else:
			segment_rotation = steps_array[i]*90 - 90
		var segment_flip = false
		if steps_array[i - 1] == RIGHT and steps_array[i] == UP:
			segment_flip = true
		if steps_array[i - 1] == LEFT and steps_array[i] == DOWN:
			segment_flip = true
		if steps_array[i - 1] == DOWN and steps_array[i] == RIGHT:
			segment_flip = true
		if steps_array[i - 1] == UP and steps_array[i] == LEFT:
			segment_flip = true
		spawn_path_element(
			cells_array[i],
			segment,
			segment_rotation,
			segment_flip
		)
	spawn_path_element(
		cells_array[-1],
		TARGET_SEGMENT,
		steps_array[-1]*90
	)

func spawn_path_element(
		cell: Vector2i,
		cell_segment: int,
		cell_rotation: int,
		flip: bool = false
	):
	var sprite2d = Sprite2D.new()
	sprite2d.texture = texture.duplicate()
	sprite2d.texture.region = Rect2(cell_segment * 32, 0, 32, 32)
	sprite2d.rotation_degrees = cell_rotation
	sprite2d.position = tile_map.grid_to_position(cell)
	if flip:
		sprite2d.scale.y = -1
	add_child(sprite2d)
