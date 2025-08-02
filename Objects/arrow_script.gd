class_name arrow
extends Node2D

@export var type : Weapon_Base_Resource

@onready var bullet = preload("res://Objects/Bullet.tscn")

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	rotation_degrees = wrap(rotation_degrees, 0,360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1
	
	shoot("Fire")

func shoot(event:String)->void:
	if Input.is_action_just_pressed(event) and on_cooldown(type.attack_cooldown):
		var bullet_obj = bullet.instantiate()
		get_tree().root.add_child(bullet_obj)
		(bullet_obj as Node2D).global_position = global_position
		(bullet_obj as Node2D).rotation = rotation
		bullet_obj.Damage.emit(type.damage)

func on_cooldown(seconds:float)->bool:
	return true if get_tree().create_timer(seconds).timeout else false
