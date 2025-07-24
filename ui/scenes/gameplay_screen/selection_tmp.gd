extends Label

func _ready() -> void:
	EventBus.unit_selected.connect(handle_unit_selected)
	EventBus.unit_deselected.connect(handle_unit_deselected)

func handle_unit_selected(unit: Unit):
	text = unit.character.name

func handle_unit_deselected():
	text = ""
