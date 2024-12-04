extends Control

var good_hits: int
var total_hits: int
var note_hit_array: Array[NoteHitData]

@onready var accuracy_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Accuracy
@onready var total_hits_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/TotalHits
@onready var good_hits_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/GoodHits
@onready var bad_hits_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/BadHits
@onready var statistics_container: MarginContainer = $MarginContainer/VBoxContainer/HBoxContainer/StatisticsContainerMargin/StatisticsContainerVBox/StatisticsContainer
@onready var options_button: OptionButton = $MarginContainer/VBoxContainer/HBoxContainer/StatisticsContainerMargin/StatisticsContainerVBox/OptionButton
@onready var file_dialog: FileDialog = $FileDialog
@onready var feedback: Label = $MarginContainer/VBoxContainer/HBoxContainer/StatisticsContainerMargin/StatisticsContainerVBox/FeedbackText

var line_chart_scene: PackedScene = preload("res://ui/line_chart/LineChart.tscn")
var score_grid_scene: PackedScene = preload("res://ui/score_grid/static/score_grid.tscn")


func _ready() -> void:
	good_hits = DataManager.good_hit_counter
	total_hits = DataManager.note_hits.size()
	note_hit_array = DataManager.note_hits
	var accuracy: float = 0
	if total_hits > 0:
		accuracy = float(good_hits) / float(total_hits)
	var bad_hits: int = total_hits - good_hits

	accuracy_label.text = str(accuracy * 100).pad_decimals(1) + "%"
	total_hits_label.text = str(total_hits)
	good_hits_label.text = str(good_hits)
	bad_hits_label.text = str(bad_hits)
	feedback.text = ""
	
	instansiate_score_grid()


func instansiate_line_chart() -> void:
	var line_chart: LineChart = line_chart_scene.instantiate()
	
	if total_hits == 1:
		line_chart.x_ticks = 0
	elif total_hits < 20:
		line_chart.x_ticks = total_hits 
	else:
		line_chart.x_ticks = 20
	
	var accuracy_over_time: Array = instansiate_accuracy_over_time()
	line_chart.data = accuracy_over_time
	statistics_container.add_child(line_chart)


func instansiate_score_grid() -> void:
	var score_grid = score_grid_scene.instantiate()
	statistics_container.add_child(score_grid)


func instansiate_accuracy_over_time() -> Array:
	var good_hit_counter: float = 0
	var index: float = 0
	var accuracy: float = 0
	var accuracy_over_time_array: Array = []
	note_hit_array = DataManager.note_hits
	for note_hit in note_hit_array:
		index += 1
		if(note_hit.good_hit):
			good_hit_counter += 1
		accuracy = good_hit_counter / index * 100
		accuracy_over_time_array.append({'x': index, 'y':accuracy})
	return accuracy_over_time_array


func clear_statistics_container() -> void:
	for child in statistics_container.get_children():
		child.queue_free()


func _on_option_button_item_selected(index: int) -> void:
	if (index == 0):
		clear_statistics_container()
		instansiate_score_grid()
	elif (index == 1):
		clear_statistics_container()
		instansiate_line_chart()


func _on_statistics_container_resized() -> void:
	if (options_button.selected == 1):
		clear_statistics_container()
		instansiate_line_chart()

func save_to_csv(file_path: String) -> void:
	var file = FileAccess.open(file_path, FileAccess.WRITE)

	if file == null:
		feedback.text = "Failed to save"
		return

	file.store_line("good_hit,cut_direction,hit_type,line_index,line_layer")

	for note_hit in note_hit_array:
		var csv_line: String = str(note_hit.good_hit) + "," + str(note_hit.note_data.cut_direction) + "," + str(note_hit.note_data.hit_type) + "," + str(note_hit.note_data.line_index) + "," + str(note_hit.note_data.line_layer)
		file.store_line(csv_line)

	file.close()
	feedback.text = "File saved"


func _on_save_file_button_pressed() -> void:
	file_dialog.filters = ["*.csv"]
	file_dialog.popup()


func _on_file_dialog_file_selected(path: String) -> void:
	save_to_csv(path)


func _on_main_menu_burron_pressed() -> void:
	DataManager.reset_data()
	Radio.change_ui_scene.emit("res://scenes/admin/main_menu/main_menu.tscn")


func _on_new_test_button_pressed() -> void:
	DataManager.reset_data()
	Radio.change_ui_scene.emit("res://scenes/admin/param_panel/param_panel.tscn")
