extends OptionButton

@export_range(1, 12, 1) var max_scale: int = 6

func _ready():
	for i in max_scale:
		var item_scale = i+1
		add_item(Resolution.scale_to_resolution_string(item_scale), item_scale)
	selected = Resolution.current_scale - 1
	Resolution.scale_changed.connect(_on_viewport_manager_scale_changed)
	$".".item_selected.connect(_on_item_selected)

func _on_item_selected(index):
	Resolution.set_window_size(index + 1, false)

func _on_viewport_manager_scale_changed(new_scale: int):
	selected = new_scale - 1
