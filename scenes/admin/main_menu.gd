extends Control

func _on_start_button_pressed() -> void:
	Radio.change_ui_scene.emit("res://scenes/admin/admin.tscn")
	
