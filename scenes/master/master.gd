extends Node
class_name Master

@onready var game: Game = $Game
@onready var admin: Admin = $AdminWindow/Admin


func _ready() -> void:
	Radio.start.emit()


func _on_admin_window_close_requested() -> void:
	get_tree().quit()
