extends Control


func _on_stop_test_button_pressed() -> void:
	Radio.stop.emit()
	Radio.change_ui_scene.emit("res://scenes/admin/param_panel/param_panel.tscn")
