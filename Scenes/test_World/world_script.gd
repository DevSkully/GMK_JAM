class_name World
extends Node2D

var tower : Tower
var car : Car

func _ready() -> void:
	assign_car_to_tower()

func assign_car_to_tower()->void:
	for child in get_children():
		if child is Tower:
			tower = child
		if child is Car:
			car = child
	car.Center_Offset.emit(tower.global_position)

func spawn_enemies()->void:
	pass
