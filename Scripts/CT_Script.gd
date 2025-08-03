class_name Tower
extends Node2D

@export var Health : float = 1000

@onready var sprite = $Sprite2D/AnimatedSprite2D
@onready var hurt_audio = preload("res://Assets/zap.wav")
@onready var explode_audio = preload("res://Assets/explosion4.wav")


var enemies : Array[Enemy]
var can_damage:bool = true

func _tower_destroy()->void:
	sprite.play("Destroyed")
	await sprite.animation_finished
	GameManager._loss()

func recieve_damage(damage:float)->void:
	if Health - damage <= 0 :
		_tower_destroy()
		tower_explode_sound()
	else:
		Health -= damage 
		sprite.play("damaged")
		tower_hurt_sound()
		await sprite.animation_finished
		sprite.play("default")

func tower_hurt_sound()->void:
	var audio : AudioStreamPlayer2D = AudioStreamPlayer2D.new()
	self.add_child(audio)
	audio.stream = hurt_audio
	audio.play()
	
func tower_explode_sound()->void:
	var audio : AudioStreamPlayer2D = AudioStreamPlayer2D.new()
	self.add_child(audio)
	audio.stream = explode_audio
	audio.play() 
	
func _process(delta: float) -> void:
	var total_damage : float
	for child in enemies:
		total_damage += child.type.damage
	if can_damage and !enemies.is_empty():
		can_damage = false
		recieve_damage(total_damage)
		await get_tree().create_timer(2).timeout
		can_damage = true

func enemy_entered(node:Node2D):
	if node is Enemy:
		enemies.append(node)

func enemy_exit(node:Node2D)->void:
	if node is Enemy:
		enemies.erase(node)
