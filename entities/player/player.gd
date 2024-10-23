extends XROrigin3D

const HitType = Radio.HitType

@onready var left_rumbler: XRToolsRumbler = $LeftHand/LeftRumbler
@onready var right_rumbler: XRToolsRumbler = $RightHand/RightRumbler


func _ready() -> void:
	Radio.note_hit.connect(note_hit)


func note_hit(hit_type: HitType):
	if hit_type == HitType.LEFT:
		left_rumbler.rumble()
	else:
		right_rumbler.rumble()
