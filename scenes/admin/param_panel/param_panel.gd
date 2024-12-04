extends Control
class_name Admin

const GameParam = Enums.GameParam

@onready var navbar: Navbar = $Navbar
@onready var song_speed_slider: Slider = $Sidebar/MainMargin/MainVBox/ParamsVbox/SongSpeedContainer/song_speed_slider
@onready var note_speed_slider: Slider = $Sidebar/MainMargin/MainVBox/ParamsVbox/NoteSpeedContainer/note_speed_slider
@onready var beat_tempo_slider: Slider = $Sidebar/MainMargin/MainVBox/ParamsVbox/BeatTempoContainer/beat_tempo_slider
@onready var spawn_ditance_slider: Slider = $Sidebar/MainMargin/MainVBox/ParamsVbox/SpawnDistanceContainer/spawn_distance_slider

func _enter_tree() -> void:
	Radio.send_game_params.connect(update_slider_values)


func _exit_tree() -> void:
	Radio.exited_param_panel.emit()
	Radio.send_game_params.disconnect(update_slider_values)


func _ready() -> void:
	Radio.entered_param_panel.emit()
	navbar.show_navbar()


func _on_start_test_button_pressed() -> void:
	Radio.start.emit()
	Radio.change_ui_scene.emit("res://scenes/admin/run_test_panel/run_test_panel.tscn")


func _on_song_speed_slider_value_changed(value: float) -> void:
	Radio.update_game_param.emit(GameParam.SONG_SPEED, value)


func _on_note_speed_slider_value_changed(value: float) -> void:
	Radio.update_game_param.emit(GameParam.NOTE_SPEED, value)


func _on_beat_tempo_slider_value_changed(value: float) -> void:
	Radio.update_game_param.emit(GameParam.BEAT_TEMPO, value)


func _on_spawn_distance_slider_value_changed(value: float) -> void:
	Radio.update_game_param.emit(GameParam.SPAWN_DISTANCE, value)


func update_slider_values(params: Dictionary) -> void:
	song_speed_slider.value = params[GameParam.SONG_SPEED]
	note_speed_slider.value = params[GameParam.NOTE_SPEED]
	beat_tempo_slider.value = params[GameParam.BEAT_TEMPO]
	spawn_ditance_slider.value = params[GameParam.SPAWN_DISTANCE]


func _on_song_speed_slider_mouse_entered() -> void:
	song_speed_slider.set_default_cursor_shape(CURSOR_POINTING_HAND)


func _on_note_speed_slider_mouse_entered() -> void:
	note_speed_slider.set_default_cursor_shape(CURSOR_POINTING_HAND)


func _on_beat_tempo_slider_mouse_entered() -> void:
	beat_tempo_slider.set_default_cursor_shape(CURSOR_POINTING_HAND)


func _on_spawn_distance_slider_mouse_entered() -> void:
	spawn_ditance_slider.set_default_cursor_shape(CURSOR_POINTING_HAND)
