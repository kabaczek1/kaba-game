extends Node

@warning_ignore("unused_signal")
signal cursor_cell_changed(Vector2i)
@warning_ignore("unused_signal")
signal cursor_over_unit(GridUnit)
@warning_ignore("unused_signal")
signal cursor_left_main_grid()

@warning_ignore("unused_signal")
signal unit_selected(GridUnit)
@warning_ignore("unused_signal")
signal unit_deselected()
@warning_ignore("unused_signal")
signal unit_cell_changed(GridUnit)
@warning_ignore("unused_signal")
signal unit_movement_animation_ended(GridUnit)

@warning_ignore("unused_signal")
signal player_turn_ended()
@warning_ignore("unused_signal")
signal turn_number_changed(int)
