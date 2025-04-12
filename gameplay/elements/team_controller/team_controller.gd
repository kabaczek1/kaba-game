extends Node

class_name TeamController

@export var team_name: String = "Player Team"
@export var player_controlled: bool = true
@export var team: Enums.Team
@export var start_turn_message: String = "PLAYER TURN"


func _init(
	_team_name: String,
	_player_controlled: bool,
	_team: Enums.Team,
	_start_turn_message: String = "PLAYER TURN"
	):
	team_name = _team_name
	player_controlled = _player_controlled
	team = _team
	start_turn_message = _start_turn_message

func get_units():
	return get_children()
