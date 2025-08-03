extends Node

var world = preload("res://Scenes/test_World/world.tscn")
var loss = preload("res://Scenes/GUI/Game_Loss.tscn")
var main_menu = preload("res://Scenes/GUI/main_menu.tscn")

func _ready() -> void:
	Engine.max_fps = 60

func _start()->void:
	get_tree().change_scene_to_packed(world)

func _loss()->void:
	get_tree().paused = true
	get_tree().change_scene_to_packed(world)
