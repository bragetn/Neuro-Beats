extends Node
class_name NoteSpawner

@export var note_groups: Array[NoteGroup] = []

var note_scene: PackedScene = preload("res://entities/note/note.tscn")

var weighted_sum: int = 0

var spawn_distance: float = 10
var note_speed: float = 1


func start() -> void:
	weighted_sum = 0
	for note_group in note_groups:
		weighted_sum += note_group.weight


func spawn() -> void:
	var note_group = get_random_note_group()
	for note_data in note_group:
		instantiate_note(note_data)


func instantiate_note(note_data) -> void:
	var note: Note = note_scene.instantiate()
	note.position = get_note_position(note_data.line_index, note_data.line_layer)
	note.start(note_data.color, note_data.cut_direction, note_speed)
	add_child(note)


func get_random_note_group() -> NoteGroup:
	var random = randi_range(0, weighted_sum - 1)
	for note_group in note_groups:
		if random < note_group.weight:
			return note_group
		random -= note_group.weight
	return null


func get_note_position(line_index, line_layer) -> Vector3:
	return Vector3(-0.75 + line_index * 0.5, 1 + line_layer * 0.5, -spawn_distance)
