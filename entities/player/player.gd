extends XROrigin3D

const HitType = Radio.HitType

@onready var left_rumbler: XRToolsRumbler = $LeftHand/LeftRumbler
@onready var right_rumbler: XRToolsRumbler = $RightHand/RightRumbler

var xr_active: bool = false


func _ready() -> void:
	Radio.note_hit.connect(note_hit)


func _on_start_xr_xr_started() -> void:
	xr_active = true


func _on_start_xr_xr_ended() -> void:
	xr_active = false


func note_hit(hit_type: HitType) -> void:
	if xr_active:
		if hit_type == HitType.LEFT:
			left_rumbler.rumble()
		else:
			right_rumbler.rumble()
