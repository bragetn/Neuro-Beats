extends Node
class_name Master

@onready var game: Game = $Game
@onready var ui_window: Window = $AdminWindow

var current_ui_scene: Node


func _ready() -> void:
	Radio.change_ui_scene.connect(change_ui_scene)
	current_ui_scene = ui_window.get_child(0)


func _on_admin_window_close_requested() -> void:
	get_tree().quit()


func change_ui_scene(path: String) -> void:
	var scene = load(path).instantiate()
	ui_window.add_child(scene) 
	ui_window.remove_child(current_ui_scene)
	current_ui_scene = scene
