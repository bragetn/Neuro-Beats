extends Control

@onready var score_grid: ScoreGrid = $Sidebar/MainMargin/MainVBox/ScoreGrid


func _ready() -> void:
	DataManager.score_grid_updated.connect(score_grid_updated)


func _on_stop_test_button_pressed() -> void:
	Radio.stop.emit()
	Radio.change_ui_scene.emit("res://scenes/admin/param_panel/param_panel.tscn")


func score_grid_updated():
	score_grid.update()
