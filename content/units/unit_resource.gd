extends Resource

class_name UnitResource

@export var name: String = "UnitName"
@export var description: String = "UnitDescription"
@export var icon: Texture
@export var texture: Texture

@export var base_hp: int = 3
@export var base_ap: int = 2
@export var base_move: int = 3

@export var move_ability: Ability
@export var attack_ability: Ability
@export var abilities: Array[Ability]
