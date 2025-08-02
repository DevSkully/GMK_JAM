class_name Tower
extends Node2D

@export var Health : float

@onready var sprite = $Sprite2D/AnimatedSprite2D

func _tower_destroy()->void:
	sprite.play("Destroyed")
	await sprite.animation_finished

func enemy_enetered(node:Node2D):
	if node is Enemy:
		_tower_destroy()

func recieve_damage()->void:
	pass
