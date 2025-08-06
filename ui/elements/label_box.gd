extends MarginContainer

@onready var label: Label = $PanelContainer/MarginContainer/Label

func _ready() -> void:
	hide()
	EventBus.enemy_turn_started.connect(func ():
		display_text("Enemy turn")
	)
	EventBus.player_turn_started.connect(func ():
		display_text("Player turn")
	)

func display_text(text):
	label.text = text
	show()
	var timer = get_tree().create_timer(2.0)
	timer.timeout.connect(func():
		hide()
	)
