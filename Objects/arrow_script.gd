class_name arrow
extends Node2D

@export var type : Weapon_Base_Resource

@onready var bullet = preload("res://Objects/Bullet.tscn")
@onready var muzzle:Marker2D = $Marker2D

var attack_cooldown : bool = true

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	rotation_degrees = wrap(rotation_degrees, 0,360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1
	
	print(attack_cooldown)
	if attack_cooldown:
		shoot("Fire")

func shoot(event:String)->void:
	if Input.is_action_just_pressed(event):
		attack_cooldown = false
		var bullet_obj = bullet.instantiate()
		get_tree().root.add_child(bullet_obj)
		(bullet_obj as Node2D).global_position = muzzle.global_position
		(bullet_obj as Node2D).rotation = rotation
		bullet_obj.Damage.emit(type.damage)
		on_cooldown(type.attack_cooldown)

func on_cooldown(seconds:float)->void:
	await get_tree().create_timer(seconds).timeout
	attack_cooldown = true
