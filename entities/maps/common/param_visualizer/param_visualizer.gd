extends Node3D
class_name ParamVisualizer

const GameParam = Enums.GameParam

@onready var mesh_instance: MeshInstance3D = $MeshInstance3D
@onready var material: ShaderMaterial = $MeshInstance3D.material_override


func update(game_params: Dictionary) -> void:
	_update_mesh_instance(game_params)
	_update_shader_params(game_params)


func _update_mesh_instance(game_params: Dictionary) -> void:
	var spawn_distance = game_params[GameParam.SPAWN_DISTANCE]
	mesh_instance.mesh.size.y = spawn_distance
	mesh_instance.position.z = -spawn_distance / 2.0


func _update_shader_params(game_params: Dictionary) -> void:
	material.set_shader_parameter("bpm", game_params[GameParam.BPM])
	material.set_shader_parameter("song_speed", game_params[GameParam.SONG_SPEED])
	material.set_shader_parameter("beat_tempo", game_params[GameParam.BEAT_TEMPO])
	material.set_shader_parameter("note_speed", game_params[GameParam.NOTE_SPEED])
	material.set_shader_parameter("spawn_distance", game_params[GameParam.SPAWN_DISTANCE])
