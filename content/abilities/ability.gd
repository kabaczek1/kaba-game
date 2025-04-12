extends Resource

class_name Ability

@export var name: String = "AbilityName"
@export var description: String = "AbilityDescription"
@export var icon: Texture

@export var has_cost: bool = true
@export var cost: int = 1

@export var has_range: bool = false
@export var grid_range: int

@export var has_damage: bool = false
@export var damage: int

@export var has_res: bool = false #resource
@export var res: int
@export var res_name: String

@export var allow_multiple_uses_per_turn: bool = false
var used: bool = false

@export var input_steps: Array[AbilityInputStep]

@export var command: GDScript #Command https://www.reddit.com/r/godot/comments/138el4k/using_scripts_via_an_export_variable/
#@export var ability_input: AbilityInput
#@export var ability_validator: AbilityResolver
