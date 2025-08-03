class_name Enemy
extends CharacterBody2D

@export var type : Enemy_Base_Resource

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var _health = type.health

var tower : Node2D
var is_allive:bool = true

func _ready() -> void:
	sprite.play("Walking")
func on_death()->void:
	set_physics_process(false)
	GameManager.set_count(1)
	sprite.play("Death")
	is_allive = false
	await sprite.animation_finished
	queue_free()
func recieve_damage(damage)->void:
	if _health - damage == 0:
		on_death()
	else:
		_health -= damage
func _process(delta: float) -> void:
	look_at((tower as Node2D).global_position)
	rotation += deg_to_rad(-90)
func _physics_process(delta: float) -> void:
	var tower_dir:Vector2 = ((tower as Node2D).global_position - global_position).normalized()
	var distance = global_position.distance_to((tower as Node2D).global_position)
	
	if distance > 150:
		self.velocity = tower_dir * type.speed
	else:
		self.velocity = Vector2.ZERO
	
	move_and_slide()
