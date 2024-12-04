extends Node
class_name NoteSpawner

const GameParam = Enums.GameParam

@export var note_groups: Array[NoteGroup] = []

var note_scene: PackedScene = preload("res://entities/note/scenes/note.tscn")

var weighted_sum: int = 0

var bpm: float = 110
var song_speed: float = 1
var note_speed: float = 1
var spawn_distance: float = 10

var note_velocity: float = 1


func setup(game_params: Dictionary) -> void:
	bpm = game_params[GameParam.BPM]
	song_speed = game_params[GameParam.SONG_SPEED]
	note_speed = game_params[GameParam.NOTE_SPEED]
	spawn_distance = game_params[GameParam.SPAWN_DISTANCE]
	note_velocity = ((spawn_distance - 1.5) / ((60.0 / bpm) * (2**(6 - note_speed)))) * song_speed
	
	weighted_sum = 0
	for note_group in note_groups:
		weighted_sum += note_group.weight
	
	spawn()


func spawn() -> void:
	var note_group: NoteGroup = get_random_note_group()
	for note_data in note_group.notes:
		instantiate_note(note_data)


func instantiate_note(note_data) -> void:
	var note: Note = note_scene.instantiate()
	note.position = get_note_position(note_data.line_index, note_data.line_layer)
	add_child(note)
	note.setup(note_data, note_velocity)


func get_random_note_group() -> NoteGroup:
	var random: int = randi_range(0, weighted_sum - 1)
	for note_group in note_groups:
		if random < note_group.weight:
			return note_group
		random -= note_group.weight
	return null


func get_note_position(line_index, line_layer) -> Vector3:
	return Vector3(-0.75 + line_index * 0.5, 1 + line_layer * 0.5, -spawn_distance)
