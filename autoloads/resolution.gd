extends Node

signal scale_changed(scale: int)

#const resolution_confirm_scene = preload("res://ui/main_menu/resolution_confirm/resolution_confirm.tscn")

var base_resolution = Vector2i(640, 360)
var current_scale: int = 2 #also display/window/size/window_width_override

@warning_ignore("unused_parameter")
func set_window_size(scale: int, confirm: bool = false):
	var new_size = base_resolution * scale
	get_window().size = new_size
	#if confirm:
		#show_resolution_confirm_scene(scale)
	current_scale = scale
	scale_changed.emit(current_scale)

#func show_resolution_confirm_scene(scale: int):
	#var scene = resolution_confirm_scene.instantiate()
	#scene.setup(scale, current_scale, 5.0)
	#get_tree().root.add_child(scene)

func scale_to_resolution(scale) -> Vector2i:
	return base_resolution * scale

func scale_to_resolution_string(scale) -> String:
	var resolution = scale_to_resolution(scale)
	return "%dx%d" % [resolution.x, resolution.y]
