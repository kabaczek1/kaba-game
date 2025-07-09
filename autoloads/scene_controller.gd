extends Node

signal scene_loaded()

@export var transition_scene: PackedScene

@export var title_screen: PackedScene
@export var battle_scene: PackedScene

@export var war_room_screen: PackedScene
@export var world_map_screen: PackedScene
@export var quarters_screen: PackedScene
@export var magic_workshop_screen: PackedScene
@export var gameplay_screen: PackedScene
@export var mission_summary_screen: PackedScene

func change_to_battle_scene():
	change_to_scene(battle_scene)

func go_to_war_room():
	change_to_scene(war_room_screen)

func go_to_world_map():
	change_to_scene(world_map_screen)

func go_to_quarters():
	change_to_scene(quarters_screen)

func go_to_magic_workshop():
	change_to_scene(magic_workshop_screen)

func go_to_gameplay():
	change_to_scene(gameplay_screen)

func go_to_mission_summary():
	change_to_scene(mission_summary_screen)

func change_to_scene(scene: PackedScene):
	var transition = transition_scene.instantiate()
	get_tree().root.add_child(transition)
	await transition.transition_scene_animation_fully_in
	get_tree().change_scene_to_packed(scene)
	print("before EventBus.scene_loaded")
	await scene_loaded
	print("after EventBus.scene_loaded")
	transition.animate_out()
	print("after transition.animate_out()")
