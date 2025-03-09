@tool
extends GridObject

class_name GridUnit

@export var team: int = 0
@export var speed: int = 2

var remaining_speed

var selectable = false

func _ready() -> void:
	new_turn()
	EventBus.unit_deselected.connect(make_selectable)
	EventBus.unit_selected.connect(on_any_unit_selected)

func on_any_unit_selected(_unit):
	make_unselectable()

func _process(delta):
	if Engine.is_editor_hint():
		position = cell * 32
		position.x += 32
		position.y += 32

func move(target_path: Array[Vector2i]):
	print("move ", target_path)
	var tween = get_tree().create_tween()
	for move_cell in target_path:
		var new_position = move_cell * 32
		new_position.x += 32
		new_position.y += 32
		var aa = Vector2(new_position)
		tween.tween_property($".", "position", aa, 1)
	cell = target_path[-1]

func make_selectable():
	EventBus.cursor_cell_changed.connect(on_cursor_cell_changed)
	selectable = true

func make_unselectable():
	if EventBus.cursor_cell_changed.is_connected(on_cursor_cell_changed):
		EventBus.cursor_cell_changed.disconnect(on_cursor_cell_changed)
	selectable = false

func _exit_tree() -> void:
	if EventBus.cursor_cell_changed.is_connected(on_cursor_cell_changed):
		EventBus.cursor_cell_changed.disconnect(on_cursor_cell_changed)

func on_cursor_cell_changed(cursor_cell):
	if cell == cursor_cell:
		EventBus.cursor_over_unit.emit(self)

func new_turn():
	print("aaaa")
	remaining_speed = speed
	make_selectable()
