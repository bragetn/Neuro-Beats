extends Control
class_name Admin

const GameParam = Radio.GameParam

func _on_button_pressed() -> void:
	Radio.start.emit()


func _on_song_speed_slider_value_changed(value: float) -> void:
	Radio.update_game_param.emit(GameParam.SONG_SPEED, value)


func _on_note_speed_slider_value_changed(value: float) -> void:
	Radio.update_game_param.emit(GameParam.NOTE_SPEED, value)


func _on_beat_tempo_slider_value_changed(value: float) -> void:
	Radio.update_game_param.emit(GameParam.BEAT_TEMPO, value)


func _on_spawn_distance_slider_value_changed(value: float) -> void:
	Radio.update_game_param.emit(GameParam.SPAWN_DISTANCE, value)
