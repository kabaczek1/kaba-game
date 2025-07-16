extends Resource

class_name Character

@export var portrait: Texture
@export var sprite: Texture
@export var name: String = "Charater"
@export var description: String = "Charater Description"
@export var maxhp: int = 3
var hp: int
@export var move_ability: Ability
@export var attack_ability: Ability
@export var catch_ability: Ability
@export var item: Item

func setup():
	hp = maxhp
