extends Node

#https://godotforums.org/d/36464-what-is-the-best-way-to-declare-and-use-global-enums

enum TargetType {
	GROUND,
	OBSTACLE,
	EMPTY,
	OBJECT,
	UNIT,
	ENEMY,
	ALLY,
	SELF,
	PATH
}

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

enum Shape {
	CIRCLE,
	SQUARE
}

enum Team {
	PLAYER,
	ENEMY
}
