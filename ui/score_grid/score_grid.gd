extends Control
class_name ScoreGrid

@onready var grid_container: GridContainer = $GridMargin/GridContainer

var cells: Array


func _ready() -> void:
	cells = grid_container.get_children()


func update():
	var score_grid = DataManager.score_grid
	for i in range(3):
		for j in range(4):
			var cell: Label = cells[4 * (2 - i) + j]
			var score: Vector2i = score_grid[i][j]
			
			if score.x + score.y == 0:
				cell.text = ""
			else:
				var value: float = score.x / float(score.x + score.y)
				cell.text = str(value * 100).pad_decimals(1) + "%"
