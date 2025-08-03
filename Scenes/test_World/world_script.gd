class_name World
extends Node2D

@export var enemy : Array[PackedScene]
@export var enemy_spawn_timer : float = 2.50

@onready var score : Label = $Label
@onready var SpawnTimer:Timer = Timer.new()

var margin = 200
var cap = 10

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
	
	var enemy_obj = type_enemy().instantiate()
	self.add_child(enemy_obj)
	(enemy_obj as CharacterBody2D).global_position = obj_position
	enemy_obj.tower = get_node("CentralTower")

func type_enemy()->PackedScene:
	if cap >= 20 and cap < 50:
		enemy_spawn_timer += 0.50
		return enemy[randi_range(0,1)]
	#elif cap >= 50:
		#return enemy[randi_range(0,2)]
	else:
		return enemy[0]

func _process(delta: float) -> void:
	score.text = "Score : " + str(GameManager.count)
	
	if GameManager.count >= cap and enemy_spawn_timer - 0.25 >= 0:
		cap += 10
		enemy_spawn_timer -= 0.25
		SpawnTimer.start(enemy_spawn_timer)
