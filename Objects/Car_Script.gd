class_name Car
extends CharacterBody2D

@export var speed : float = 1.5
 
@onready var tower = get_node("../CentralTower") 

var radius : float = 0.0
var angle : float = 0.0

func _ready() -> void: 
	# get radius from distance between car and tower in the world
	radius = global_position.distance_to(tower.global_position)

func motion()->void:
	angle -= speed * get_physics_process_delta_time()
	var x_pos = cos(angle)
	var y_pos = sin(angle)
	position.x = radius * x_pos + tower.global_position.x
	position.y = radius * y_pos + tower.global_position.y
	rotation = atan2(position.y - tower.global_position.y, position.x - tower.global_position.x)

func _physics_process(delta: float) -> void:
	motion()
	move_and_slide()

func hit_enemy(obj:Node2D)->void:
	if obj is Enemy:
		obj.on_death()
