extends Node

signal score_grid_updated()

var note_hits: Array[NoteHitData]
var score_grid: Array[Array]
var good_hit_counter: int

func _ready() -> void:
	Radio.start.connect(instansiate_score_grid)
	good_hit_counter = 0


func instansiate_score_grid() -> void:
	for i in range(3):
		var row: Array = []
		for j in range(4):
			row.append(Vector2i())
		score_grid.append(row)


func reset_data() -> void:
	note_hits.clear()
	score_grid.clear()
	good_hit_counter = 0


func register_hit(hit_data: NoteHitData) -> void:
	note_hits.append(hit_data)
	if(hit_data.good_hit):
		score_grid[hit_data.note_data.line_layer][hit_data.note_data.line_index].x += 1
		good_hit_counter += 1
	else:
		score_grid[hit_data.note_data.line_layer][hit_data.note_data.line_index].y += 1
	
	score_grid_updated.emit()
