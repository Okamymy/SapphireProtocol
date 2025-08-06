extends CharacterBody2D

@export var life : float = 100
@export var damage = 10
@export var speed : float = 300
@export var bullet_scene: PackedScene
@export var fire_rate : float = 5

signal playerHit(actualife: float)
signal playerDeath

var is_shooting = false
var can_shoot = true
var screen_size

func _ready():
	screen_size = get_viewport().size

func _process(delta):
	$AnimatedSprite2D.play("idle")
	# Movimiento del jugador
	var input_vector = get_input_vector()
	velocity = input_vector * speed
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	# Detectar incio y fin del disparo
	if Input.is_action_just_pressed("shoot"):
		start_shooting()
	elif Input.is_action_just_released("shoot"):
		stop_shooting()
	
	if is_shooting and can_shoot:
		shoot()
	
	if life <= 0:
		emit_signal("playerDeath")

func get_input_vector() -> Vector2:
	var input_vector = Vector2(
	Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 
	Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))
	return input_vector.normalized()

func start_shooting():
	is_shooting = true
	print("Esta shoot")

func stop_shooting():
	is_shooting = false
	print("No shoot")

func shoot():
	if bullet_scene:
		can_shoot = false
		
		#instanciar la bala
		var bullet = bullet_scene.instantiate()
		bullet.position = $Gun.global_position
		bullet.direction = Vector2.UP
		get_tree().current_scene.add_child(bullet)
		
		$GunSound.play()
		
		#Espera y habilitacion
		await get_tree().create_timer(fire_rate).timeout
		can_shoot = true #Permite siguiente disparo


func _on_bullet_collision_area_entered(area):
	if area.is_in_group("Bullet_Enemy"):
		life = life - damage
		print(life)
		emit_signal("playerHit", life)
