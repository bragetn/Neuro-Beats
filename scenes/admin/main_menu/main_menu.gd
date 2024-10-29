extends Control


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_start_button_pressed() -> void:
	#Radio.change_ui_scene.emit("res://scenes/admin/admi_panel/admin.tscn")
	print("help") #not printing
	
	
	# Teori: StartButton sender signal til Right_sidebar, men sendes ikke videre til MainMenu lengre
	# Dette gjør at den ikke bytter scene
