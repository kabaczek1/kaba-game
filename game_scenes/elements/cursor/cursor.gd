extends Sprite2D

@onready var main_layer: TileMapLayer = $"../MainLayer"
@onready var offset_layer: TileMapLayer = $"../OffsetLayer"

@export var overshoot_pixels = 4
@export var moving_time = 0.1:
	set(value):
		set_move_and_overshoot_times(value, overshoot_ratio)
		moving_time = value
@export var overshoot_ratio = 0.4:
	set(value):
		set_move_and_overshoot_times(moving_time, value)
		overshoot_ratio = value

func set_move_and_overshoot_times(new_moving_time, new_overshoot_ratio):
	time_to_overshoot = new_moving_time * new_overshoot_ratio
	time_to_position = new_moving_time - time_to_overshoot

var time_to_overshoot = 0.05
var time_to_position = 0.05

var last_snapped_position: Vector2 = Vector2(16,16)

func _input(event):
	if event is InputEventMouseMotion:
		update_position(event.position)

func update_position(event_position):
	var new_snapped_position = main_layer.snapped_position(event_position)
	if last_snapped_position != new_snapped_position:
		move_cursor(new_snapped_position)
		last_snapped_position = new_snapped_position

func move_cursor(new_position):
	var overshoot = position - new_position
	overshoot = overshoot.normalized()
	overshoot = overshoot * overshoot_pixels
	
	var tween = get_tree().create_tween()
	tween.tween_property($".", "position", new_position - overshoot, time_to_overshoot)
	tween.tween_property($".", "position", new_position, time_to_position)
