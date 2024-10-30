extends Node

var note_hits: Array[NoteHitData]
var score_grid: Array[Array]

func _ready() -> void:
	instansiate_score_grid()


func instansiate_score_grid() -> void:
	for i in range(3):
		var row = []
		for j in range(4):       
			row.append(Vector2i())       
		score_grid.append(row)


func register_hit(hit_data: NoteHitData) -> void:
	note_hits.append(hit_data)
	if(hit_data.hit):
		score_grid[hit_data.note_data.line_layer][hit_data.note_data.line_index].x += 1
	else:
		score_grid[hit_data.note_data.line_layer][hit_data.note_data.line_index].y += 1
