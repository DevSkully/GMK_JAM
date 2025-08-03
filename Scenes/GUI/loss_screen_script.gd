extends Control

func _resume()->void:
	get_tree().paused = false
	get_tree().change_scene_to_packed(GameManager.main_menu)
