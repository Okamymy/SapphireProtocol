extends Area2D

@export var move_distance: float = 75.0
@export var move_speed: float = 25.0

var base_x_position: float
var direction: int = 1

func _ready():
	base_x_position = global_position.x

func _process(delta):
	horizon_movement(delta)

func horizon_movement(delta):
	global_position.x += direction * move_speed * delta

	if abs(global_position.x - base_x_position) >= move_distance:
		direction *= -1  # Cambia de dirección
