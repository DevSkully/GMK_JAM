extends Node

var world = preload("res://Scenes/test_World/world.tscn")
var loss = preload("res://Scenes/GUI/Game_Loss.tscn")
var main_menu = preload("res://Scenes/GUI/main_menu.tscn")

var count : int : set = set_count
func set_count(score:int)->void:
	count += score

var upgrade_score : int = 50

func _ready() -> void:
	Engine.max_fps = 60
func _start()->void:
	count = 0
	get_tree().change_scene_to_packed(world)
func _loss()->void:
	get_tree().change_scene_to_packed(loss)
