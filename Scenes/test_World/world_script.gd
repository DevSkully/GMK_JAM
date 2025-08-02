class_name World
extends Node2D

@export var enemy_spawn_timer : float = 2.5

@onready var SpawnTimer:Timer = Timer.new()

var enemy = preload("res://Objects/enemy.tscn")
var margin = 200

func _ready() -> void:
	timer()
func timer()->void:
	add_child(SpawnTimer)
	SpawnTimer.timeout.connect(spawn_enemy)
	SpawnTimer.start(enemy_spawn_timer)
func spawn_enemy()->void:
	var viewport_area : Vector2 = get_viewport_rect().size
	
	var arr_spawn:Array[Vector2] = [
		#TOP
		Vector2(randf_range(-margin, viewport_area.x + margin), -margin),
		#BOTTOM
		Vector2(randf_range(-margin, viewport_area.x + margin), viewport_area.y + margin),
		#LEFT
		Vector2(-margin, randf_range(-margin, viewport_area.y + margin)),
		#RIGHT
		Vector2(viewport_area.x + margin, randf_range(-margin, viewport_area.y + margin))
	]
	
	var obj_position : Vector2 = arr_spawn[randf_range(0,3)]
	
	var enemy_obj = enemy.instantiate()
	get_tree().root.add_child(enemy_obj)
	(enemy_obj as Node2D).global_position = obj_position
	enemy_obj.tower = get_node("CentralTower")

func play_time()->void:
	pass

func loss()->void:
	get_node("Car").set_physics_process(false)
