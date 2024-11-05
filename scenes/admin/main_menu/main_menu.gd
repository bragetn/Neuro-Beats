extends Control


func _on_start_button_pressed() -> void:
	Radio.change_ui_scene.emit("res://scenes/admin/param_panel/param_panel.tscn")


func _on_stats_button_pressed() -> void:
	Radio.change_ui_scene.emit("res://scenes/admin/user_statistics_panel/user_statistics_panel.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
