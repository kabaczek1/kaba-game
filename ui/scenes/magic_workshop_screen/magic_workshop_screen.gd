extends Node2D

@export var war_room_button: Button
@export var item_select_container: Container


func _ready() -> void:
	war_room_button.pressed.connect(func ():
		print(war_room_button)
		SceneController.go_to_war_room()
	)
	
	if MissionController.current_mission.item_available == true:
		load_rewards()
		
	SceneController.scene_loaded.emit()


func load_rewards():
	for item in MissionController.current_mission.item_pool:
		var button = Button.new()
		button.text = item.name
		item_select_container.add_child(button)
		
		button.pressed.connect(
			get_item.bind(item)
		)
	
		
func get_item(item):
	GlobalController.items.append(item)
	MissionController.current_mission.collect_reward()
	purge_item_container()
	# set special quarter item mode?
	SceneController.go_to_quarters()
	
	
func purge_item_container():
	for n in item_select_container.get_children():
		n.queue_free()
