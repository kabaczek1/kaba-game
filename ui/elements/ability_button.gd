extends TextureButton

var ability: Ability
var unit: Unit

func load(_unit: Unit, _ability: Ability):
	unit = _unit
	ability = _ability
	if unit.moved and ability.type == Enums.AbilityType.MOVE:
		disabled = true
	if unit.used_ability and ability.type == Enums.AbilityType.ATTACK:
		disabled = true
	if unit.used_ability and ability.type == Enums.AbilityType.CATCH:
		disabled = true
	texture_normal = ability.icon

func _pressed() -> void:
	print(ability.name)
	EventBus.ability_button_pressed.emit(unit, ability)
