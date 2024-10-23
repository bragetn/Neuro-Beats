extends Control
class_name Admin

func _on_button_pressed() -> void:
	Radio.start.emit()


# Switching scenes to the note controll panel
func _go_to_controll() -> void:
	get_tree().change_scene_to_file("res://scenes/admin/note_controller.tscn")
