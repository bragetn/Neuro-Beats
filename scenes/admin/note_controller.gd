extends Control


# Switching scenes to Admin 
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/master/master.tscn")
