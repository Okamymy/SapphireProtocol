extends Area2D

@export var speed: float = 900
@export var effect: String = "nothing"
@export var damage: int = 100
@export var min_damage: int = 8 

@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.wait_time = 1.0
	timer.one_shot = false
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

func _physics_process(delta: float) -> void:
	position.x += delta * speed

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	var target_enemy = area.get_parent()
	if target_enemy is Enemy:
		target_enemy.getDamage(damage, effect)
		queue_free()

func _on_timer_timeout():
	if damage > min_damage:
		damage -= 1
