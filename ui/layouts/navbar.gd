extends Control
class_name Navbar

@onready var main_menu_button = $MarginContainer/HBoxContainer/MainMenuButton
@onready var padding: Label = $MarginContainer/HBoxContainer/Padding

func _on_main_menu_button_pressed() -> void:
	DataManager.reset_data()
	Radio.change_ui_scene.emit("res://scenes/admin/main_menu/main_menu.tscn")


func _on_main_menu_button_mouse_entered() -> void:
	main_menu_button.set_default_cursor_shape(CURSOR_POINTING_HAND)


func show_navbar() -> void:
	main_menu_button.visible = true
	padding.visible = true
