extends Node2D

class_name Unit

var character: Character
var cell: Vector2i

var team: Enums.Team
var moved: bool = false
var used_ability: bool = false

func setup():
	%Sprite2D.texture = character.sprite
	position = GameplayController.cell_to_position(cell)
	
func is_ally():
	return GameplayController.turn_owner == team
