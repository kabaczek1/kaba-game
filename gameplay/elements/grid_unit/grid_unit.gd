extends Node2D

class_name GridUnit
var sprite_2d: Sprite2D
var animation_player: AnimationPlayer

@export var unit_res: UnitResource

@export var team: Enums.Team
@export_range(0.5, 3, 0.5) var animation_speed: float = 1
@export var cell: Vector2i
var speed: int

var moved: bool = false
var used_ability: bool = false

var movement_animation_active: bool = false

var is_selected: bool

func setup(_unit_res: UnitResource, _team: Enums.Team, _cell: Vector2i):
	unit_res = _unit_res
	team = _team
	cell = _cell
	position = BattleController.cell_to_position(cell)

func new_turn():
	moved = false
	used_ability = false

func _ready() -> void:
	sprite_2d = $Sprite2D
	animation_player = $AnimationPlayer
	unit_res = unit_res.duplicate()
	sprite_2d.texture = unit_res.texture
	@warning_ignore_start("integer_division")
	sprite_2d.hframes = sprite_2d.texture.get_width()/100
	sprite_2d.vframes = sprite_2d.texture.get_height()/100
	@warning_ignore_restore("integer_division")
	speed = unit_res.base_move
	is_selected = false
	modulate.a = 0.6
	animation_player.play("idle")

func glance_start():
	modulate.a = 0.8
	EventBus.unit_glance_started.emit(self)

func glance_stop():
	modulate.a = 0.6
	EventBus.unit_glance_stopped.emit(self)

func select():
	print(name, " selected")
	is_selected = true
	modulate.a = 1
	EventBus.unit_selected.emit(self)

func deselect():
	print(name, " deselected")
	is_selected = false
	modulate.a = 0.6
	EventBus.unit_deselected.emit(self)

func move(target_path: Array[Vector2i]):
	target_path.pop_front()
	assert(len(target_path) > 0, "move error, incorrect target path")
	cell = target_path[-1]
	movement_animation_active = true
	move_one_cell(target_path)

func move_one_cell(target_path: Array[Vector2i]):
	#print("move_one_cell ", target_path)
	var tween = get_tree().create_tween()
	
	#fixit
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
