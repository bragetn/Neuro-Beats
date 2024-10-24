extends XROrigin3D

const HitType = Radio.HitType

@onready var left_rumbler: XRToolsRumbler = $LeftHand/LeftRumbler
@onready var right_rumbler: XRToolsRumbler = $RightHand/RightRumbler

var rumble_active: bool = false


func _ready() -> void:
	Radio.start.connect(start)
	Radio.stop.connect(stop)
	Radio.note_hit.connect(note_hit)


func start():
	rumble_active = true


func stop():
	rumble_active = false


func note_hit(hit_type: HitType):
	if rumble_active:
		if hit_type == HitType.LEFT:
			left_rumbler.rumble()
		else:
			right_rumbler.rumble()
