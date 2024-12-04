extends Control


func _on_menu_button_pressed() -> void:
	Radio.change_ui_scene.emit("res://scenes/admin/main_menu/main_menu.tscn")
