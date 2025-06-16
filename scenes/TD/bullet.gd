class_name  Bullet
extends Area2D
var speed:float=900

func _physics_process(delta: float) -> void:
	position.x += delta * speed


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	queue_free()




func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	#if body in Enemy
		#aplay damage
	queue_free()
