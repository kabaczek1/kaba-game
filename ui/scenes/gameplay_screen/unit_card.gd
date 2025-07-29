extends MarginContainer

@onready var name_label: Label = %NameLabel
@onready var hp_label: Label = %HPLabel
@onready var move_ability_button: TextureButton = %MoveAbilityButton
@onready var attack_ability_button: TextureButton = %AttackAbilityButton
@onready var catch_ability_button: TextureButton = %CatchAbilityButton

func _ready() -> void:
	hide()
	EventBus.unit_selected.connect(load_unit_info)
	EventBus.unit_deselected.connect(hide_unit_card)
	EventBus.unit_hover_started.connect(load_unit_info)
	EventBus.unit_hover_stopped.connect(hide_unit_card)

func load_unit_info(unit: Unit):
	show()
	name_label.text = unit.character.name
	hp_label.text = unit.character.name # temp
	move_ability_button.texture_normal = unit.character.move_ability.icon
	attack_ability_button.texture_normal = unit.character.attack_ability.icon
	catch_ability_button.texture_normal = unit.character.catch_ability.icon
	

func hide_unit_card(_unit: Unit):
	hide()
	name_label.text = ""
