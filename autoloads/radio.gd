extends Node

enum GameParam {
	BPM,
	SONG_SPEED,
	BEAT_TEMPO,
	NOTE_SPEED,
	SPAWN_DISTANCE,
}

signal start

signal stop

signal update_game_param(param: GameParam, value)
