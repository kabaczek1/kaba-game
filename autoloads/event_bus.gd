extends Node

@warning_ignore_start("unused_signal")
signal cursor_cell_changed(cell: Vector2i)
signal cursor_cell_clicked(cell: Vector2i)
signal cursor_over_unit(unit: GridUnit)
signal cursor_left_main_grid()





signal turn_number_changed(number: int)

signal move_undid()

signal info_box_animation_finished()

signal state_entered(name: String)
@warning_ignore_restore("unused_signal")

#new
@warning_ignore_start("unused_signal")
signal unit_movement_animation_ended(unit: GridUnit)
signal unit_movement_animation_started(unit: GridUnit)

signal unit_selected(unit: GridUnit)
signal unit_deselected(unit: GridUnit)
signal unit_glance_started(unit: GridUnit)
signal unit_glance_stopped(unit: GridUnit)

signal unit_cell_changed(unit: GridUnit)

signal player_turn_started()
signal player_turn_ended()

signal battle_scene_loaded(bs: BattleScene)
@warning_ignore_restore("unused_signal")
