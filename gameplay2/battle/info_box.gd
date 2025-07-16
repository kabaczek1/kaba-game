extends MarginContainer

class_name InfoBox

@export var label: Label

func display(_text: String) -> bool:
	label.text = _text
	var tween = self.create_tween()
	tween.tween_property($".", "modulate:a", 1, 0.3)
	tween.tween_interval(0.8)
	tween.tween_property($".", "modulate:a", 0, 0.3).set_trans(Tween.TRANS_BOUNCE)
	await tween.finished
	EventBus.info_box_animation_finished.emit()
	return true
