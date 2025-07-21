extends Node2D

class_name Room

@export var enemies: Array[Character]
@export var next_room: PackedScene # Room

@onready var layout: TileMapLayer = %Layout
@onready var markers: TileMapLayer = %Markers


var entrance_cell: Vector2i
var exit_cell: Vector2i
var ally_spawn_cells: Array[Vector2i]
var enemy_spawn_cells: Array[Vector2i]

func _ready() -> void:
	load_tile_markers()

func load_tile_markers() -> void:
	markers.update_internals()
	var tile_markers = markers.get_children()
	for m in tile_markers:
		#print(m.label, GameplayController.position_to_cell( m.position))
		var cell = GameplayController.position_to_cell(m.position)
		match m.label:
			"entrance":
				entrance_cell = cell
			"exit":
				exit_cell = cell
			"ally_spawn":
				ally_spawn_cells.append(cell)
			"enemy_spawn":
				enemy_spawn_cells.append(cell)
