class_name World
extends Node2D

@export var enemy_spawn_timer : float = 2.50

@onready var score : Label = $Label
@onready var tower = $CentralTower
@onready var SpawnTimer:Timer = Timer.new()

@onready var normal_zombie = preload("res://Objects/enemies/enemy.tscn")
@onready var jockey_zombie = preload("res://Objects/enemies/Jockey.tscn")
@onready var tank_zombie = preload("res://Objects/enemies/Tank_Zombie.tscn")

var enemy : Array[PackedScene]

var margin = 200
var difficult_cap = 10

func _ready() -> void:
	enemy = [normal_zombie, jockey_zombie, tank_zombie]
	GameManager.audio_player(self)
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
	
	var enemy_obj = type_enemy().instantiate()
	self.add_child(enemy_obj)
	(enemy_obj as Node2D).global_position = obj_position
	enemy_obj.tower = tower

func type_enemy()->PackedScene:
	if GameManager.count == 20:
		enemy_spawn_timer += 0.25
		return enemy[randi_range(0,1)]
	elif GameManager.count == 50:
		enemy_spawn_timer += 1.00
		return enemy[randi_range(0,2)]
	else:
		return enemy[0]

func _process(delta: float) -> void:
	score.text = "Score : " + str(GameManager.count)
	
	if GameManager.count >= difficult_cap and enemy_spawn_timer - 0.25 >= 0:
		difficult_cap += 10
		enemy_spawn_timer -= 0.25
		SpawnTimer.start(enemy_spawn_timer)
