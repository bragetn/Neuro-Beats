extends Control

@onready var grid_container: GridContainer = $GridMargin/GridContainer

var cells: Array


func _ready() -> void:
	cells = grid_container.get_children()
	update()


func update() -> void:
	var score_grid = DataManager.score_grid
	for i in range(3):
		for j in range(4):
			var cell = cells[4 * (2 - i) + j]
			var score: Vector2i = score_grid[i][j]
			
			if score.x + score.y == 0:
				cell.percent = ""
				cell.score = ""
			else:
				var value: float = score.x / float(score.x + score.y)
				cell.percent = str(value * 100).pad_decimals(1) + "%"
				cell.score = str(score.x) + " / " + str(score.x + score.y)
				update_cell_style(cell, value)

func update_cell_style(cell, value: float) -> void:
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
