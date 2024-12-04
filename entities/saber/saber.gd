@tool
extends Node3D
class_name Saber

const HitType = Enums.HitType

@export var hit_type: HitType

@onready var saber_mesh: MeshInstance3D = $Saber
@onready var start_point: Node3D = $StartPoint
@onready var end_point: Node3D = $EndPoint

var mask: int
var prev_position: Vector3


func _ready() -> void:
	prev_position = end_point.global_position
	update_hit_type()


func _physics_process(_delta: float) -> void:
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(start_point.global_position, end_point.global_position, mask)
	var result = space_state.intersect_ray(query)
	
	if result:
		Radio.note_hit.emit(hit_type)
		var note: Note = result.collider.get_parent()
		var hit_vector: Vector3 = end_point.global_position - prev_position
		var hit_normal: Vector3 = hit_vector.cross(end_point.global_position - start_point.global_position).normalized()
		note.slice(hit_type, hit_vector, hit_normal, result.position)
	
	prev_position = end_point.global_position


func update_hit_type() -> void:
	var color: Color
	if hit_type == HitType.LEFT:
		color = Color(1, 0, 0)
		mask = 4
	else:
		color = Color(0, 0, 1)
		mask = 8
	
	saber_mesh.set_instance_shader_parameter("color", color)
