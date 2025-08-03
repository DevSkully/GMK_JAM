class_name Tower
extends Node2D

@export var Health : float = 1000

@onready var sprite = $Sprite2D/AnimatedSprite2D

var enemies : Array[Enemy]
var can_damage:bool = true

func _tower_destroy()->void:
	sprite.play("Destroyed")
	await sprite.animation_finished
	get_tree().change_scene_to_packed(GameManager.loss)

func recieve_damage(damage:float)->void:
	if Health - damage <= 0 :
		_tower_destroy()
	else:
		Health -= damage 

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
