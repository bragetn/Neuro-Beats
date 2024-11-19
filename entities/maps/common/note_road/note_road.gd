extends Node3D
class_name NoteRoad

const GameParam = Enums.GameParam

@onready var spatial_grid: Node3D = $SpatialGrid
@onready var param_visualizer: ParamVisualizer = $ParamVisualizer


func _ready() -> void:
	Radio.entered_param_panel.connect(show_visualizer)
	Radio.exited_param_panel.connect(hide_visualizer)
	hide_visualizer()


func update(game_params: Dictionary) -> void:
	param_visualizer.update(game_params)
	
	spatial_grid.position.z = -game_params[GameParam.SPAWN_DISTANCE]


func show_visualizer() -> void:
	spatial_grid.show()
	param_visualizer.show()


func hide_visualizer() -> void:
	spatial_grid.hide()
	param_visualizer.hide()
