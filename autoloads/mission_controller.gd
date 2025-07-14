extends Node

@export var missions: Array[Mission]
@export var current_mission: Mission

func set_mission(mission):
	current_mission = mission

func complete_mission():
	current_mission.complete_mission()
	if current_mission.next_mission != null:
		current_mission.next_mission.make_available()
