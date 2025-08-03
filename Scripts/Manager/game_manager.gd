extends Node

var world = preload("res://Scenes/test_World/world.tscn")
var loss = preload("res://Scenes/GUI/Game_Loss.tscn")
var main_menu = preload("res://Scenes/GUI/main_menu.tscn")

var count : int : set = set_count
func set_count(score:int)->void:
	count = score

var upgrade_score : int = 50

@onready var background_audio : AudioStream = preload("res://Assets/ItsAScreamBaby.mp3")
@onready var game_over_audio : AudioStream = preload("res://Assets/Jumpscare.mp3")


func _ready() -> void:
	Engine.max_fps = 60
func _start()->void:
	get_tree().change_scene_to_packed(world)
	count = 0
func _loss()->void:
	get_tree().change_scene_to_packed(loss)

func increase_count(value:int)->void:
	count += value

func audio_player(object:Variant)->void:
	var audio : AudioStreamPlayer2D = AudioStreamPlayer2D.new()
	object.add_child(audio)
	audio.stream = background_audio
	audio.play()

func game_over(object:Variant)->void:
	var audio : AudioStreamPlayer2D = AudioStreamPlayer2D.new()
	object.add_child(audio)
	audio.stream = game_over_audio
	audio.play()
