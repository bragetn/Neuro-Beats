extends GridContainer
class_name LineChart

@export var line_width : float = 5.0
@export var line_color : Color
@export var bg_color : Color

@export var x_label : String = ""
@export var y_label : String = ""

@export var x_ticks : int = 20
var y_ticks : int = 11

@export var data = [] 


@onready var line : Line2D = $LineContainer/Line
@onready var line_container : Control = $LineContainer
@onready var background : ColorRect = $LineContainer/Background
@onready var x_label_element : Label = $XLabel
@onready var y_label_element : Label = $YLabel
@onready var x_ticks_container : Control = $XTicksContainer
@onready var y_ticks_container : Control = $YTicksContainer

var x_numerical : bool = true
var y_numerical : bool = true

var min_x : float
var min_y : float
var max_x : float
var max_y : float

var line_rect_width : float
var line_rect_height : float

var line_rect_x : float
var line_rect_y : float


func _ready():
	line.clear_points()
	line.default_color = line_color
	line.width = line_width
	
	x_label_element.text = x_label
	y_label_element.text = y_label
	background.color = bg_color
	
	# check if values are numerical
	for val in data:
		if not [TYPE_INT, TYPE_FLOAT].has(typeof(val['x'])):
			x_numerical = false
		if not [TYPE_INT, TYPE_FLOAT].has(typeof(val['y'])):
			y_numerical = false
		
	# get min and max values (use index if value isn't a number, e.g. weekdays)
	for i in range(len(data)):
		var x_val = get_val(data[i]['x'], i)
		var y_val = get_val(data[i]['y'], i)
		
		if min_x == null or x_val < min_x:
			min_x = x_val
		if max_x == null or x_val > max_x:
			max_x = x_val
		if min_y == null or y_val < min_y:
			min_y = y_val
		if max_y == null or y_val > max_y:
			max_y = y_val
		
	max_y = 100
	min_x = 1
	# add tick labels to each axis
	for i in range(x_ticks):
		var x_tick = Label.new()
		x_tick.size_flags_horizontal = SIZE_EXPAND_FILL
		x_tick.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		if x_numerical:
			x_tick.text = str(round(i * (max_x - min_x) / (x_ticks - 1) + min_x))
		else:
			x_tick.text = str(data[i]['x'])
		x_ticks_container.add_child(x_tick)

	for i in range(y_ticks-1, -1, -1):
		var y_tick = Label.new()
		y_tick.size_flags_vertical = SIZE_EXPAND_FILL
		y_tick.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		if y_numerical:
			y_tick.text = str(round(i * (max_y - min_y) / (y_ticks - 1) + min_y)) + " %" 
		else:
			y_tick.text = str(data[y_ticks - i - 1]['y'])
		y_ticks_container.add_child(y_tick)
	
	# Wait until the next frame to update layout
	await get_tree().create_timer(0).timeout

	# shape the line
	line_rect_width = line_container.size.x
	line_rect_height = line_container.size.y
	
	line_rect_x = line_rect_width / x_ticks
	line_rect_y = line_rect_height / y_ticks
	
	line_rect_width = line_rect_x * (x_ticks - 1)
	line_rect_height = line_rect_y * (y_ticks - 1)

	# Debugging: check if scaling values are correct
	for i in range(len(data)):
		var scaled_x = scale_x(get_val(data[i]['x'], i))
		var scaled_y = scale_y(get_val(data[i]['y'], i))
		
		line.add_point(Vector2(scaled_x, scaled_y))

func scale_x(val : float) -> float:
	var dx = max_x - min_x
	return ((val - min_x) * line_rect_width / dx) + line_rect_x / 2

func scale_y(val : float) -> float:
	var dy = max_y - min_y
	return line_rect_height - ((val - min_y) * line_rect_height / dy) + line_rect_y / 2

func get_val(val, idx : int) -> float:
	if typeof(val) in [TYPE_INT, TYPE_FLOAT]:
		return float(val)
	return float(idx)
