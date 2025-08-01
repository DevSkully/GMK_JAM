extends Node2D

@export var speed : float = 100

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_exit()->void:
	self.queue_free()
