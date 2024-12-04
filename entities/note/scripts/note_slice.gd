extends RigidBody3D
class_name NoteSlice

const HitType = Enums.HitType
const CutDirection = Enums.CutDirection

@onready var note_mesh: MeshInstance3D = $NoteMesh

var miss_position: float = 0.5
var fade_distance: float = 2.0

func setup(note_data: NoteData, hit_normal: Vector3, plane_position: Vector3) -> void:
	var color: Color
	if note_data.hit_type == HitType.LEFT:
		color = Color(1, 0, 0)
	else:
		color = Color(0, 0, 1)
	
	var plane_normal: Vector3 = hit_normal.rotated(Vector3.FORWARD, rotation.z)
	
	if note_data.cut_direction == CutDirection.ANY:
		note_mesh.set_instance_shader_parameter("dot_note", true)
	
	note_mesh.set_instance_shader_parameter("color", color)
	note_mesh.set_instance_shader_parameter("plane_normal", plane_normal)
	note_mesh.set_instance_shader_parameter("plane_position", plane_position)
	
	apply_impulse(hit_normal * 2.5)


func _process(delta: float) -> void:
	note_mesh.set_instance_shader_parameter("t", (position.z - miss_position) / fade_distance)
	if position.z >= miss_position + fade_distance:
		queue_free()
