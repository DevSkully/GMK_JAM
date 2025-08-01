class_name Car
extends CharacterBody2D

signal Center_Offset(Vector2)

@export var radius : float = 200.0
@export var speed : float = 1.5

var tower : Vector2
var angle : float = 0.0

func _ready() -> void:
	Center_Offset.connect(_offset)

func _offset(center:Vector2)->void:
	tower = center

func motion()->void:
	angle += speed * get_physics_process_delta_time()
	var x_pos = cos(angle)
	var y_pos = sin(angle)
	position.x = radius * x_pos + tower.x
	position.y = radius * y_pos + tower.y

func _physics_process(delta: float) -> void:
	motion()
	move_and_slide()
