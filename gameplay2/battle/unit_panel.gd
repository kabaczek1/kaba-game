extends HBoxContainer

@export var icon: TextureRect
@export var name_label: Label
@export var move_label: Label
@export var ap_label: Label
@export var hp_label: Label
@export var ability_buttons: Container

@export var ability_button_scene: PackedScene

const move_format: String = "MOVE:%d"
const ap_format: String = "AP:%d"
const hp_format: String = "HP:%d"

func _ready() -> void:
	hide()
	EventBus.unit_selected.connect(_on_unit_selected)
	EventBus.unit_deselected.connect(_on_unit_deselected)
	EventBus.unit_glance_started.connect(_on_unit_selected)
	EventBus.unit_glance_stopped.connect(_on_unit_deselected)

func _on_unit_selected(unit):
	show()
	icon.texture = unit.unit_res.icon
	name_label.text = unit.unit_res.name
	move_label.text = move_format % unit.speed
	hp_label.text = hp_format % unit.unit_res.base_hp
	ap_label.text = ap_format % unit.unit_res.base_ap
	var move_button_instance = ability_button_scene.instantiate()
	move_button_instance.set_ability(unit.unit_res.move_ability)
	ability_buttons.add_child(move_button_instance)
	var attack_button_instance = ability_button_scene.instantiate()
	attack_button_instance.set_ability(unit.unit_res.attack_ability)
	ability_buttons.add_child(attack_button_instance)
	for ability in unit.unit_res.abilities:
		var ability_button_instance = ability_button_scene.instantiate()
		ability_button_instance.set_ability(ability)
		ability_buttons.add_child(ability_button_instance)

func _on_unit_deselected(_unit):
	hide()
	var buttons = ability_buttons.get_children()
	for b in buttons:
		b.queue_free()
