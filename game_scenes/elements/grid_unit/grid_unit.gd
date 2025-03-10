@tool
extends GridObject

class_name GridUnit

@export_enum("player", "enemy") var team: int = 0
@export_range(0.5, 3, 0.5) var animation_speed: float = 1
@export var speed: int = 2

var can_move
var movement_animation_active: bool = false
var is_selected: bool:
	set(value):
		if value:
			modulate.a = 1
		else:
			modulate.a = 0.6
		is_selected = value

var remaining_speed:
	set(value):
		if value > 0:
			can_move = true
		else:
			can_move = false
		remaining_speed = value

func _ready() -> void:
	is_selected = false
	if team == 0:
		EventBus.cursor_cell_changed.connect(on_cursor_cell_changed)
	new_turn()

func _process(_delta):
	if Engine.is_editor_hint():
		position = cell * 32
		position.x += 32
		position.y += 32

func move(target_path: Array[Vector2i]):
	target_path.pop_front()
	assert(len(target_path) > 0, "move error, incorrect target path")
	cell = target_path[-1]
	remaining_speed -= len(target_path)
	movement_animation_active = true
	move_one_cell(target_path)

func move_one_cell(target_path: Array[Vector2i]):
	print("move_one_cell ", target_path)
	var tween = get_tree().create_tween()
	
	var target_cell = target_path.pop_front()
	var new_position = target_cell * 32
	new_position.x += 32
	new_position.y += 32
	var aa = Vector2(new_position)
	
	tween.tween_property($".", "position", aa, 0.1 * animation_speed).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_interval(0.1 * animation_speed)
	await tween.finished
	
	EventBus.unit_cell_changed.emit(self)
	if len(target_path) <= 0:
		movement_animation_active = false
		EventBus.unit_movement_animation_ended.emit(self)
		return
	else:
		move_one_cell(target_path)

func on_cursor_cell_changed(cursor_cell):
	if cell == cursor_cell:
		EventBus.cursor_over_unit.emit(self)

func new_turn():
	remaining_speed = speed
	if remaining_speed > 0:
		can_move = true
