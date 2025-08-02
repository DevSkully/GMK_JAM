extends Node2D

signal Damage(float)

@export var speed : float = 200

var damage : float : set = set_damage
func set_damage(dmg:float)->void:
	damage = dmg

func _ready() -> void:
	Damage.connect(set_damage)

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_exit()->void:
	self.queue_free()
