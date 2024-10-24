extends Node

enum HitType {
	LEFT,
	RIGHT,
}

enum GameParam {
	BPM,
	SONG_SPEED,
	BEAT_TEMPO,
	NOTE_SPEED,
	SPAWN_DISTANCE,
}

signal start

signal stop

signal note_hit(hit_type: HitType)

signal update_game_param(param: GameParam, value)

signal change_ui_scene(path: String)
