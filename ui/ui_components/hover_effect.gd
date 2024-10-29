extends Button

var overlay: TextureRect

func _ready() -> void:
	overlay = $OverlayTexture
	overlay.visible = false



func _on_mouse_entered() -> void:
	overlay.visible = true
	set_default_cursor_shape(CURSOR_POINTING_HAND)


func _on_mouse_exited() -> void:
	overlay.visible = false
