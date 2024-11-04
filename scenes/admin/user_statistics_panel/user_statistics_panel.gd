extends Control

var good_hits: int
var total_hits: int
var note_hit_array: Array[NoteHitData]
var accuracy_over_time_array: Array[float]

@onready var accuracy_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Accuracy
@onready var total_hits_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/TotalHits
@onready var good_hits_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/GoodHits
@onready var bad_hits_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/BadHits

func _ready() -> void:
	good_hits = DataManager.good_hit_counter
	total_hits = DataManager.note_hits.size()
	note_hit_array = DataManager.note_hits
	
	var accuracy: float = float(good_hits) / float(total_hits)
	var bad_hits: int = total_hits - good_hits

	accuracy_label.text = str(accuracy * 100).pad_decimals(1) + "%"
	total_hits_label.text = str(total_hits)
	good_hits_label.text = str(good_hits)
	bad_hits_label.text = str(bad_hits)


func instansiate_accuracy_over_time() -> void:
	var good_hit_counter: float = 0
	var index: float = 0
	var accuracy: float = 0
	for note_hit in note_hit_array:
		index += 1
		if(note_hit.good_hit):
			good_hit_counter += 1
		accuracy = good_hit_counter / index * 100
		accuracy_over_time_array.append(accuracy)
