extends Node

var note_hit_data: Array[NoteHitData]
var score_grid: Array[Array]

func _ready() -> void:
	instansiate_score_grid()


func instansiate_score_grid() -> void:
	for i in range(3):
		var row = []
		for j in range(4):       
			row.append(Vector2i())       
		score_grid.append(row)


func register_hit(hit: NoteHitData) -> void:
	note_hit_data.append(hit)
	if(hit.hit):
		score_grid[hit.note_data.line_layer][hit.note_data.line_index].x += 1
	else:
		score_grid[hit.note_data.line_layer][hit.note_data.line_index].y += 1
	print(note_hit_data)
	print(score_grid)
