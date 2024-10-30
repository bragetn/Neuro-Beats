extends Control

# Specify CSV file
var file_path: String = "res://data/user_data/test_data.csv"

# Create an empty CSV data
var data_set: Array = []
var column_header: Array = []

# Define nodes
@onready var info_container = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/TestInfo
@onready var grid_container = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/GridInfo
@onready var popup_dialog = $DialogContainer/Popup

func _ready():
	# Get data from CSV file
	data_set = get_data(file_path)
	
	# Print each CSV row with labels
	for row in data_set:
		display_row(row)


func get_data(path):
	# Specify CSV file
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	info_println(" Loading CSV data...")
	
	var csv_data: Array = []
	var line_index: int = -1
	
	# Iterate each CSV line into a data set
	while !file.eof_reached():
		line_index += 1
		var line: Array = file.get_csv_line()
		
		# Get headers
		if line_index == 0:
			column_header = line
		else:
			# Append data set
			csv_data.append(line)
	
	file.close()
	
	# Remove trailing empty line(s)
	while csv_data[csv_data.size() - 1][0].is_empty():
		# Remove last array (empty line)
		csv_data.pop_back()
	
	return csv_data


func display_row(row: Array):
	# Display each column in the row with its header as a label
	for i in range(column_header.size()):
		var label_text = column_header[i] + ": " + row[i] 
		var label = Label.new()
		label.text = label_text
		info_container.add_child(label)


func info_print(value):
	info_container.text += str(value) + "\n"


func info_println(value):
	info_container.text += str(value) + "\n"
	info_container.text += "----------\n"


func grid_print(value):
	grid_container.text += str(value) + "\n"


func grid_println(value):
	grid_container.text += str(value) + "\n"
	grid_container.text += "----------\n"
