extends Node3D
class_name Note

const HitType = Radio.HitType
const GameParam = Radio.GameParam

@onready var good_hit_body: StaticBody3D = $GoodHitBody
@onready var bad_hit_body: StaticBody3D = $BadHitBody
@onready var note_mesh: MeshInstance3D = $NoteMesh

var is_active: bool = false
var velocity : float = 0
var hit_type


func setup(hit_typee, cut_direction, note_velocity) -> void:
	hit_type = hit_typee
	is_active = true
	update_hit_type(hit_type)
	update_cut_direction(cut_direction)
	velocity = note_velocity


func _physics_process(delta: float) -> void:
	if is_active:
		position.z += velocity * delta


func slice(good: bool) -> void:
	is_active = false
	good_hit_body.collision_layer = 0
	bad_hit_body.collision_layer = 0
	visible = false
	
	if good:
		print("Good slice")
	else:
		print("Bad slice")
	
	queue_free()


func update_hit_type(hit_type) -> void:
	var color: Color
	
	if hit_type == HitType.LEFT:
		good_hit_body.collision_layer = 4
		bad_hit_body.collision_layer = 8
		color = Color(1, 0, 0)
	else:
		good_hit_body.collision_layer = 8
		bad_hit_body.collision_layer = 4
		color = Color(0, 0, 1)
	
	note_mesh.set_instance_shader_parameter("color", color) 
	note_mesh.set_instance_shader_parameter("plane_normal", Vector3(0, 1, 0))
	note_mesh.set_instance_shader_parameter("plane_position", Vector3(0, -999, 0))


func update_cut_direction(cut_direction) -> void:
	if cut_direction == 0:
		rotation.z = deg_to_rad(180)
	elif cut_direction == 1:
		rotation.z = deg_to_rad(0)
	elif cut_direction == 2:
		rotation.z = deg_to_rad(-90)
	elif cut_direction == 3:
		rotation.z = deg_to_rad(90)
	elif cut_direction == 4:
		rotation.z = deg_to_rad(-135)
	elif cut_direction == 5:
		rotation.z = deg_to_rad(135)
	elif cut_direction == 6:
		rotation.z = deg_to_rad(-45)
	elif cut_direction == 7:
		rotation.z = deg_to_rad(45)
