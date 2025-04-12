extends AnimatedSprite2D

class_name Cursor

@export var main_grid: MainGrid

var main_grid_region

var on_the_main_grid: bool = false

@export_range(0.01, 3, 0.01, "or_greater", "suffix:s") var moving_time = 0.1:
	set(value):
		set_move_and_overshoot_times(value, overshoot_ratio)
		moving_time = value
@export_range(0.1, 0.9, 0.01) var overshoot_ratio = 0.5:
	set(value):
		set_move_and_overshoot_times(moving_time, value)
		overshoot_ratio = value
@export_range(1, 16, 1, "suffix:px") var overshoot_pixels = 4

func set_move_and_overshoot_times(new_moving_time, new_overshoot_ratio):
	time_to_overshoot = new_moving_time * new_overshoot_ratio
	time_to_position = new_moving_time - time_to_overshoot

var time_to_overshoot = 0.05
var time_to_position = 0.05

var last_snapped_position: Vector2 = Vector2(16,16)
var current_cell: Vector2i = Vector2i(0,0)

func _ready() -> void:
	assert(main_grid != null, "set main_grid")
	main_grid_region = main_grid.grid_region

func highlight_cell():
	play("unit_hover")

func _input(event):
	if event is InputEventMouseMotion:
		update_position(event.position)
	if event is InputEventMouseButton and event.pressed == true:
		if event.get_button_index() == MOUSE_BUTTON_LEFT:
			update_current_cell(event.position)
			if main_grid_region.has_point(current_cell):
				update_position(event.position)
				EventBus.cursor_cell_clicked.emit(current_cell)

func update_current_cell(event_position):
	current_cell = main_grid.position_to_grid(event_position)

func update_position(event_position):
	current_cell = main_grid.position_to_grid(event_position)
	var new_snapped_position = main_grid.grid_to_position(current_cell)
	if last_snapped_position != new_snapped_position:
		var current_cell_on_the_main_grid = main_grid_region.has_point(current_cell)
		move_cursor(new_snapped_position, current_cell_on_the_main_grid)
		last_snapped_position = new_snapped_position
		if current_cell_on_the_main_grid:
			on_the_main_grid = true
			EventBus.cursor_cell_changed.emit(current_cell)
		else:
			on_the_main_grid = false
			EventBus.cursor_left_main_grid.emit()

func move_cursor(new_position, overshoot_animation:bool = true):
	var overshoot_modifier = 0
	if overshoot_animation:
		overshoot_modifier = 1
	var overshoot = position - new_position
	overshoot = overshoot.normalized()
	overshoot = overshoot * overshoot_pixels * overshoot_modifier
	
	var tween = get_tree().create_tween()
	tween.tween_property($".", "position", new_position - overshoot, time_to_overshoot)
	tween.tween_property($".", "position", new_position, time_to_position)

func move_cursor_to_cell(target_cell: Vector2i):
	move_cursor(main_grid.grid_to_position(target_cell))
