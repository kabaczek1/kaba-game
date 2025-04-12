extends Node

@export var transition_scene: PackedScene

@export var title_screen: PackedScene
@export var battle_scene: PackedScene
@export var map_scene: PackedScene

func change_to_battle_scene():
	change_to_scene(battle_scene)

func change_to_map_scene():
	change_to_scene(map_scene)

func change_to_scene(scene: PackedScene):
	print("change_to_scene")
	var transition = transition_scene.instantiate()
	get_tree().root.add_child(transition)
	await transition.transition_scene_animation_fully_in
	get_tree().change_scene_to_packed(scene)
	print("before EventBus.scene_loaded")
	await EventBus.scene_loaded
	print("after EventBus.scene_loaded")
	transition.animate_out()
