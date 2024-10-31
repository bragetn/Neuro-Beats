extends Node3D
class_name Note

const HitType = Enums.HitType
const CutDirection = Enums.CutDirection
const GameParam = Enums.GameParam

@onready var note_mesh: MeshInstance3D = $NoteMesh
@onready var hit_audio_player: AudioStreamPlayer3D = $HitAudioPlayer
@onready var good_hit_body: StaticBody3D = $GoodHitBody
@onready var bad_hit_body: StaticBody3D = $BadHitBody

var note_slice_scene: PackedScene = preload("res://entities/note/scenes/note_slice.tscn")
var good_hit_audio: AudioStream = preload("res://entities/note/audio/good_hit.tres")
var bad_hit_audio: AudioStream = preload("res://entities/note/audio/bad_hit.tres")

var data: NoteData
var velocity: float
var is_active: bool


func setup(note_data: NoteData, note_velocity: float) -> void:
	update_hit_type(note_data.hit_type)
	update_cut_direction(note_data.cut_direction)
	data = note_data
	velocity = note_velocity
	is_active = true


func _physics_process(delta: float) -> void:
	if is_active:
		position.z += velocity * delta
		
		if position.z >= 5:
			queue_free()


func slice(saber_hit_type: HitType, hit_vector: Vector3, hit_normal: Vector3, hit_position: Vector3) -> void:
	# Stop and hide note
	is_active = false
	visible = false
	
	# Disable collision with sabers
	good_hit_body.collision_layer = 0
	bad_hit_body.collision_layer = 0
	
	# Rotate hit_vector to match note
	hit_vector = hit_vector.rotated(Vector3.FORWARD, rotation.z)
	
	# Check if note and saber has the same hit type
	var good: bool = false
	
	if saber_hit_type == data.hit_type:
		if data.cut_direction == CutDirection.ANY:
			good = true
			hit_audio_player.stream = good_hit_audio
		else:
			# Check if saber has the correct cut direction
			if -hit_vector.y > abs(hit_vector.x):
				good = true
				hit_audio_player.stream = good_hit_audio
			else:
				hit_audio_player.stream = bad_hit_audio
	else:
		hit_audio_player.stream = bad_hit_audio
	
	save_hit(data,good)
	
	if hit_normal == Vector3.ZERO:
		hit_normal = Vector3.LEFT
	
	# Create
	create_note_slice(hit_normal, Vector3.ZERO)
	create_note_slice(-hit_normal, Vector3.ZERO)
	
	# Play hit audio and destroy note instance
	hit_audio_player.finished.connect(func(): queue_free())
	if good:
		hit_audio_player.play(0.18)
	else:
		hit_audio_player.play()


func save_hit(note_data: NoteData, good: bool) -> void:
	var note_hit_data: NoteHitData = NoteHitData.new()
	note_hit_data.note_data = note_data
	note_hit_data.hit = good
	DataManager.register_hit(note_hit_data)


func create_note_slice(hit_normal: Vector3, hit_position: Vector3) -> void:
	var note_slice: NoteSlice = note_slice_scene.instantiate()
	add_sibling(note_slice)
	note_slice.position = position
	note_slice.rotation.z = rotation.z
	note_slice.linear_velocity.z = velocity
	note_slice.setup(data, hit_normal, hit_position)


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
	if cut_direction == CutDirection.UP:
		rotation.z = deg_to_rad(180)
	elif cut_direction == CutDirection.DOWN:
		rotation.z = deg_to_rad(0)
	elif cut_direction == CutDirection.LEFT:
		rotation.z = deg_to_rad(-90)
	elif cut_direction == CutDirection.RIGHT:
		rotation.z = deg_to_rad(90)
	elif cut_direction == CutDirection.UP_LEFT:
		rotation.z = deg_to_rad(-135)
	elif cut_direction == CutDirection.UP_RIGHT:
		rotation.z = deg_to_rad(135)
	elif cut_direction == CutDirection.DOWN_LEFT:
		rotation.z = deg_to_rad(-45)
	elif cut_direction == CutDirection.DOWN_RIGHT:
		rotation.z = deg_to_rad(45)
	elif cut_direction == CutDirection.ANY:
		note_mesh.set_instance_shader_parameter("dot_note", true)
		$GoodHitBody/CollisionShape3D.shape.size.y = 0.8
