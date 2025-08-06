extends Area2D

@export var speed : float = 400.00
@export var direction = Vector2.UP

func _process(delta):
	position += direction * speed * delta

#Destruye la bala al colisionar
func _on_body_entered(body):
	queue_free()

#Destruye la bala al salir de la pantalla
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	if not area.is_in_group("Bullet_Enemy"):
		queue_free()
