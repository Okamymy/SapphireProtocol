extends Node2D

@export var life = 10000
@export var bullet_scene: PackedScene
@export var move_distant = 100
@export var move_speed = 50
@onready var fire_point: Marker2D = $FirePoint #Punto de disparo
var spiral_angle := 0.0 #Radianes
var spiral_angle_rev := 0.0
var shootType = 0
var base_x_position: float
var direction: int = 1
var score = 0

signal scoreUpdate(points: int)
signal bossDeath

var maxLife = 0
var life3_4 = 0
var life2_4 = 0
var life1_4 = 0

func _ready():
	base_x_position = global_position.x
	maxLife = life
	life3_4 = life * 0.75 #Tres Cuartos de la vida
	life2_4 = life * 0.5 #Mitad de vida
	life1_4 = life * 0.25 #Un cuarto de vida

func _process(delta):
	horizon_movement(delta)
	$AnimatedSprite2D.play("default")
	if life >= life3_4 && life <= maxLife:
		shootType = 1
	elif life >= life2_4 && life < life3_4:
		shootType = 2
	elif life >= 0:
		emit_signal("bossDeath")

#LOGICA DE DISPAROS
func _on_shoot_timer_timeout():
	if shootType == 1:
		shoot_circle_pattern(12)

func _on_spiral_timer_timeout():
	if shootType == 2:
		shoot_spiral_pattern(1,0.15)
		shoot_spiral_pattern_reverse(1, 0.15)

func shoot_circle_pattern(bullet_count: int, initial_angle: float = 0.0):
	var angle_step = TAU / bullet_count  # TAU = 2π (360° en radianes)
	for i in range(bullet_count):
		var angle = initial_angle + i * angle_step
		var dir = Vector2.RIGHT.rotated(angle)
		shoot_bullet(dir)

func shoot_spiral_pattern(bullet_count: int = 1, angle_step: float = 0.1):
	for i in range(bullet_count):
		var angle = spiral_angle + i * (TAU / bullet_count)
		var dir = Vector2.RIGHT.rotated(angle)
		shoot_bullet(dir)
	# Incrementa para la próxima ráfaga
	spiral_angle += angle_step

func shoot_spiral_pattern_reverse(bullet_count: int = 1, angle_step: float = 0.1):
	for i in range(bullet_count):
		var angle = spiral_angle_rev + i * (TAU / bullet_count)
		var dir = Vector2.LEFT.rotated(angle)
		shoot_bullet(dir)
	# Incrementa para la próxima ráfaga
	spiral_angle_rev -= angle_step

func shoot_bullet(direction: Vector2):
	if bullet_scene:
		var bullet = bullet_scene.instantiate()
		bullet.position = fire_point.global_position
		bullet.direction = direction
		get_tree().current_scene.add_child(bullet)


func horizon_movement(delta):
	global_position.x += direction * move_speed * delta
	if abs(global_position.x - base_x_position) >= move_distant:
		direction *= -1

func _on_claws_area_entered(area):
	life = life - 5
	emit_signal("scoreUpdate", 15)
	print(life)

func _on_body_area_entered(area):
	life = life - 20
	emit_signal("scoreUpdate", 40)
	print(life)
