extends Control
class_name ScoreGrid

@onready var grid_container: GridContainer = $GridMargin/GridContainer

var cells: Array


func _ready() -> void:
	cells = grid_container.get_children()


func update() -> void:
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
				update_cell_style(cell, value)


func update_cell_style(cell: Label, value: float) -> void:
	var gradient_data := {
		0.0: Color.RED,
		0.5: Color.YELLOW,
		1.0: Color.GREEN,
	}

	var gradient := Gradient.new()
	gradient.offsets = gradient_data.keys()
	gradient.colors = gradient_data.values()
	
	var stylebox: StyleBox = cell.get_theme_stylebox("normal").duplicate()
	stylebox.bg_color = gradient.sample(value)
	cell.add_theme_stylebox_override("normal", stylebox)
