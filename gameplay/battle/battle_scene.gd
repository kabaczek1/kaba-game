extends Node2D

class_name BattleScene

@export var main_grid: MainGrid
@export var range_grid: OffsetGrid
@export var obstacle_grid: OffsetGrid
@export var grid_path: GridPath
@export var grid_navigation: GridNavigation
@export var cursor: Cursor
@export var info_box: InfoBox

@export var level_container: Node2D
@export var teams_container: Node

func _ready() -> void:
	EventBus.battle_scene_loaded.emit(self)
	EventBus.scene_loaded.emit()
