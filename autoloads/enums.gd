extends Node

#https://godotforums.org/d/36464-what-is-the-best-way-to-declare-and-use-global-enums

enum LevelTargetType {
	GROUND = 0,
	OBSTACLE = 1,
	CHASM = 2,
	OBJECT = 3
}

enum UnitTargetType {
	UNIT,
	ENEMY,
	ALLY,
	SELF
}

enum Team {
	PLAYER,
	ENEMY
}
