extends Control

# Specify CSV file
var file_path: String = "res://data/user_data/test_data.csv"

# Create an empty CSV data
var data_set: Array = []
var column_header: Array = []

# Define nodes
@onready var info_container = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/TestInfo/InfoContainer
@onready var grid_container = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/GridInfo


func _ready():
	# Get data from CSV file
	data_set = get_data(file_path)
	
	# Print each CSV row with labels
	for row in data_set:
		display_row(row)


func get_data(path):
	# Specify CSV file
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	
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
	for i in range(column_header.size()):
		if(!string_has_number(column_header[i])):
			var label_text = column_header[i] + ": " + row[i] 
			var label = Label.new()
			label.text = label_text
			info_container.add_child(label)

func string_has_number(input_string: String) -> bool:
	var regex = RegEx.new()
	regex.compile("[0-9]") 
	return regex.search(input_string) != null
