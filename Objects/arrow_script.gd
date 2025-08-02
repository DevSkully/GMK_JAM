class_name arrow
extends Node2D

@export var type : Weapon_Base_Resource

@onready var bullet = preload("res://Objects/Bullet.tscn")
@onready var muzzleR:Marker2D = $Marker2DRight
@onready var muzzleL:Marker2D = $Marker2DLeft

var attack_cooldown : bool = true

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	rotation_degrees = wrap(rotation_degrees, 0,360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1
	
	if attack_cooldown:
		shoot("Fire")

func shoot(event:String)->void:
	if Input.is_action_just_pressed(event):
		attack_cooldown = false
		
		# TO-DO: for shotgun and rocket launcher power-ups we should use one marker
		# but for default pistols and UZI we'll use two markers -- 
	
		# instantiate right bullet 
		var bullet_objR = bullet.instantiate()
		get_tree().root.add_child(bullet_objR)
		(bullet_objR as Node2D).global_position = muzzleR.global_position
		(bullet_objR as Node2D).rotation = (get_global_mouse_position() - muzzleR.global_position).normalized().angle()
		
		# instantiate left bullet 
		var bullet_objL = bullet.instantiate()
		get_tree().root.add_child(bullet_objL)
		(bullet_objL as Node2D).global_position = muzzleL.global_position
		(bullet_objL as Node2D).rotation = (get_global_mouse_position() - muzzleR.global_position).normalized().angle()
		bullet_objL.Damage.emit(type.damage)
		
		on_cooldown(type.attack_cooldown)

func on_cooldown(seconds:float)->void:
	await get_tree().create_timer(seconds).timeout
	attack_cooldown = true
