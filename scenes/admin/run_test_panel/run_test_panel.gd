extends Control

@onready var score_grid: ScoreGrid = $Sidebar/MainMargin/MainVBox/ScoreGrid
@onready var good_hit_value_label: Label = $Sidebar/MainMargin/MainVBox/HitScoreGrid/GoodHitValueLabel
@onready var bad_hit_value_label: Label = $Sidebar/MainMargin/MainVBox/HitScoreGrid/BadHitValueLabel


func _ready() -> void:
	DataManager.score_grid_updated.connect(score_grid_updated)


func _on_stop_test_button_pressed() -> void:
	Radio.stop.emit()
	Radio.change_ui_scene.emit("res://scenes/admin/user_statistics_panel/user_statistics_panel.tscn")
	


func score_grid_updated() -> void:
	score_grid.update()
	
	var sg = DataManager.score_grid
	var total_score = Vector2i(0, 0)
	for i in range(3):
		for j in range(4):
			total_score += sg[i][j]
	
	var good_value = total_score.x / float(total_score.x + total_score.y)
	var bad_value = 1 - good_value
	
	good_hit_value_label.text = str(good_value * 100).pad_decimals(1) + "%"
	bad_hit_value_label.text = str(bad_value * 100).pad_decimals(1) + "%"
