class_name Enemy
extends CharacterBody2D

@export var type : Enemy_Base_Resource

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var _health = type.health

@onready var death_audio = preload("res://Assets/316257__littlerobotsoundfactory__zombie_31.wav")

var tower : Node2D
var is_allive:bool = true

func _ready() -> void:
	sprite.play("Walking")
func on_death()->void:
	set_physics_process(false)
	GameManager.set_count(1)
	sprite.play("Death")
	zombie_on_death_sound()
	is_allive = false
	await sprite.animation_finished
	queue_free()
func recieve_damage(damage)->void:
	if _health - damage == 0:
		on_death()
	else:
		_health -= damage
func zombie_on_death_sound()->void:
	var audio : AudioStreamPlayer2D = AudioStreamPlayer2D.new()
	self.add_child(audio)
	audio.stream = death_audio
	audio.play() 
func _process(delta: float) -> void:
	if tower:
		look_at(tower.global_position)
	rotation += deg_to_rad(-90)
func _physics_process(delta: float) -> void:
	var tower_dir:Vector2 = ((tower as Node2D).global_position - global_position).normalized()
	var distance = global_position.distance_to((tower as Node2D).global_position)
	
	if distance > 150:
		self.velocity = tower_dir * type.speed
	else:
		self.velocity = Vector2.ZERO
	
	move_and_slide()
