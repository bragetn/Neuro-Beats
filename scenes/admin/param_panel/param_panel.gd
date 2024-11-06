extends Control
class_name Admin

const GameParam = Enums.GameParam

func _enter_tree() -> void:
	Radio.entered_param_panel.emit()


func _exit_tree() -> void:
	Radio.exited_param_panel.emit()


func _on_start_test_button_pressed() -> void:
	Radio.start.emit()
	Radio.change_ui_scene.emit("res://scenes/admin/run_test_panel/run_test_panel.tscn")


func _on_note_control_button_pressed() -> void:
	pass


func _on_song_speed_slider_value_changed(value: float) -> void:
	Radio.update_game_param.emit(GameParam.SONG_SPEED, value)


func _on_note_speed_slider_value_changed(value: float) -> void:
	Radio.update_game_param.emit(GameParam.NOTE_SPEED, value)


func _on_beat_tempo_slider_value_changed(value: float) -> void:
	Radio.update_game_param.emit(GameParam.BEAT_TEMPO, value)


func _on_spawn_distance_slider_value_changed(value: float) -> void:
	Radio.update_game_param.emit(GameParam.SPAWN_DISTANCE, value)
