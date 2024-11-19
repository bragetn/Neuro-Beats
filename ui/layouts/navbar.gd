extends Control


func _on_pressed() -> void:
	DataManager.reset_data()
	Radio.change_ui_scene.emit("res://scenes/admin/main_menu/main_menu.tscn")


func _on_mouse_entered() -> void:
	set_default_cursor_shape(CURSOR_POINTING_HAND)
