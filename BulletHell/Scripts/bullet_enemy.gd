extends Area2D

@export var speed : float = 300.00
@export var direction = Vector2.ZERO
signal playerCollision

func  _ready():
	#Destruye la bala al salir de la pantalla
	$VisibleOnScreenNotifier2D.screen_exited.connect(queue_free)

func _process(delta):
	position += direction.normalized() * speed * delta

func _on_body_entered(body):
	print("Golpeo jugador")
	emit_signal("playerCollision")
	queue_free()

func _on_area_entered(area):
	if not area.is_in_group("Bullet_Player"):
		queue_free()
 
