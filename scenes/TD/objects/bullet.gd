class_name  Bullet
extends Area2D

@export var speed:float=900
@export var damage: int=31
@export var effect: String='nothing'

func _physics_process(delta: float) -> void:
	position.x += delta * speed


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()



func _on_area_entered(area: Area2D) -> void:
	var target_enemy=area.get_parent()
	if target_enemy is Enemy:
		target_enemy.getDamage(damage, effect)
		queue_free()
		
