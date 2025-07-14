extends Node2D

@export var war_room_button: Button
@export var character_card_container: Container
@export var team_container: Container
@export var team_size_label: Label

func load_characters():
	for character in GlobalController.characters:
		var button = Button.new()
		button.text = character.name
		character_card_container.add_child(button)
		
		button.pressed.connect(func ():
			add_team_member(character)
		)
		
		if len(GlobalController.team) >= GlobalController.max_team_size:
			button.disabled = true 
			
		if character in GlobalController.team:
			button.disabled = true 
		
func load_team():
	for character in GlobalController.team:
		var button = Button.new()
		button.text = character.name
		team_container.add_child(button)
		
		button.pressed.connect(func ():
			remove_team_member(character)
		)

func reload_teams():
	for n in character_card_container.get_children():
		n.queue_free()
		
	for n in team_container.get_children():
		n.queue_free()
	
	load_characters()
	load_team()
	
	team_size_label.text = "%s/%s" % [GlobalController.team_size, GlobalController.max_team_size]
	
func _ready() -> void:
	war_room_button.pressed.connect(func ():
		SceneController.go_to_war_room()
	)
	reload_teams()

	SceneController.scene_loaded.emit()

func remove_team_member(character):
	GlobalController.team.pop_at(GlobalController.team.find(character))
	reload_teams()

func add_team_member(character):
	GlobalController.team.append(character)
	reload_teams()
