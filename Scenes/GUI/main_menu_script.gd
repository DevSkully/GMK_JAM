extends Control

func _ready() -> void:
	GameManager.audio_player(self)

func _play()->void:
	GameManager._start()
