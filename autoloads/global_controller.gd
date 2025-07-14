extends Node

@export var characters: Array[Character]
var team: Array[Character]
@export var max_team_size: int = 4
var team_size: int:
	get:
		return len(team)
	set(value):
		push_warning("Cannot alter team size")
		

var items: Array[Item]


func start_new_game():
	SceneController.go_to_war_room()


# workshop to tylko wybor itemku 1/3 po misji
# po wybraniu przenosi do quarters z zaznaczeniem nowego itemu/ slotu na item
# quarters - wybor postaci(karta postaci ma slot na item) - wybor itemu
