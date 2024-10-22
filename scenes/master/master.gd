extends Node
class_name Master

@onready var game: Game = $Game

func _ready() -> void:
	game.start()

func _on_admin_window_close_requested() -> void:
	get_tree().quit()
