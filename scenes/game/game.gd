extends Node3D
class_name Game

@onready var note_spawner: NoteSpawner = $NoteSpawner
@onready var game_timer: Timer = $GameTimer


func start() -> void:
	game_timer.wait_time = 1
	game_timer.start()
	note_spawner.start()


func _on_game_timer_timeout() -> void:
	note_spawner.spawn()
