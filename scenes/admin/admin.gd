extends Control
class_name Admin

func _on_button_pressed() -> void:
	Radio.start.emit()
