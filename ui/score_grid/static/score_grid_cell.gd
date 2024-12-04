extends Label

@export var percent: String = "Percent" : set = _set_percent
@export var score: String = "Score" : set = _set_score

@onready var percentLabel: Label = $Percent
@onready var scoreLabel: Label = $Score


func _set_score(new_value: String) -> void:
	score = new_value
	update_score_label()


func _set_percent(new_value: String) -> void:
	percent = new_value
	update_percent_label()


func update_percent_label() -> void:
	if not is_instance_valid(percentLabel):
		return
	elif percentLabel != null:
		percentLabel.text = percent


func update_score_label() -> void:
	if not is_instance_valid(scoreLabel):
		return
	elif scoreLabel != null:
		scoreLabel.text = score
