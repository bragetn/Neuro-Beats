extends Node3D
class_name Note

@onready var good_hit_body: StaticBody3D = $GoodHitBody
@onready var bad_hit_body: StaticBody3D = $BadHitBody
@onready var note_mesh: MeshInstance3D = $NoteMesh

var is_active: bool = false
var speed : float = 0


func start(color, cut_direction, note_speed) -> void:
	is_active = true
	update_color(color)
	update_cut_direction(cut_direction)
	speed = note_speed


func _physics_process(delta: float) -> void:
	if is_active:
		position.z += speed * delta


func slice(good: bool) -> void:
	is_active = false
	good_hit_body.collision_layer = 0
	bad_hit_body.collision_layer = 0
	visible = false
	queue_free()


func update_color(color) -> void:
	var color_value: Color
	
	if color == 0:
		good_hit_body.collision_layer = 4
		bad_hit_body.collision_layer = 8
		color_value = Color(1, 0, 0)
	else:
		good_hit_body.collision_layer = 8
		bad_hit_body.collision_layer = 4
		color_value = Color(0, 0, 1)
	
	note_mesh.set_instance_shader_parameter("color", color_value) 
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
