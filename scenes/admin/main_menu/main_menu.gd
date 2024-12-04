extends Control

const GameParam = Enums.GameParam

@onready var file_dialog: FileDialog = $FileDialog

func _on_start_button_pressed() -> void:
	Radio.change_ui_scene.emit("res://scenes/admin/param_panel/param_panel.tscn")


func _on_stats_button_pressed() -> void:
	file_dialog.filters = ["*.csv"]
	file_dialog.popup()


func _on_credits_button_pressed() -> void:
	Radio.change_ui_scene.emit("res://scenes/admin/credits_panel/credits_panel.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_file_dialog_file_selected(path: String) -> void:
	load_from_csv(path)
	Radio.change_ui_scene.emit("res://scenes/admin/user_statistics_panel/user_statistics_panel.tscn")


func _enter_tree() -> void:
	Radio.update_game_param.emit(GameParam.SONG_SPEED, 1)
	Radio.update_game_param.emit(GameParam.BEAT_TEMPO, 2)
	Radio.update_game_param.emit(GameParam.NOTE_SPEED, 3)
	Radio.update_game_param.emit(GameParam.SPAWN_DISTANCE, 15)


func load_from_csv(file_path: String) -> void:
	DataManager.instansiate_score_grid()
	var file = FileAccess.open(file_path, FileAccess.READ)

	if file == null:
		print("Failed to open file!")
		return

	file.store_line("") 
	var header_line = file.get_line()
	print(header_line)

	while file.eof_reached() == false:
		var csv_line = file.get_line().strip_edges()

		var columns = csv_line.split(",")

		if columns.size() == 5:
			var note_data = NoteData.new()
			var note_hit_data = NoteHitData.new()
			note_hit_data.good_hit = columns[0] == "true"
			note_data.cut_direction = int(columns[1])
			note_data.hit_type = int(columns[2]) 
			note_data.line_index = int(columns[3]) 
			note_data.line_layer = int(columns[4]) 
			note_hit_data.note_data = note_data

			DataManager.register_hit(note_hit_data)

	file.close()
