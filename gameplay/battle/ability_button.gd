extends TextureButton

var ability: Ability

func set_ability(new_ability: Ability):
	ability = new_ability
	texture_normal = ability.icon
	texture_pressed = ability.icon
	tooltip_text = ability.description

func _pressed():
	print(ability)
