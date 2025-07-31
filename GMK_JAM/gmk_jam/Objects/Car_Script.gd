extends Sprite2D

var tween := create_tween()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		Circle_Movement()

func Circle_Movement()->void:
	reset_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", get_global_mouse_position(), 1)

func reset_tween()->void:
	if tween:
		tween.kill()
	tween = create_tween()
