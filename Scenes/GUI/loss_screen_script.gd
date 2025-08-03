extends Control

@onready var label = $Label

func _ready() -> void:
	label.text = "Final Score : " + str(GameManager.count)

func _resume()->void:
	get_tree().paused = false
	get_tree().change_scene_to_packed(GameManager.main_menu)
