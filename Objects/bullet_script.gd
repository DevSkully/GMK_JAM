extends Node2D

signal Damage(float)

@export var speed : float = 50

var damage : float : set = set_damage
func set_damage(dmg:float)->void:
	damage = dmg

func _ready() -> void:
	Damage.connect(set_damage)

func _physics_process(delta: float) -> void:
	position += transform.x * speed

func _on_exit()->void:
	self.queue_free()

func _damage_enemy(obj:Node2D)->void:
	if obj is Enemy and (obj as Enemy).is_allive:
		obj.recieve_damage(damage)
		self.queue_free()
