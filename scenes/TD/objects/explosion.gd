class_name  Explosion
extends Area2D

func _ready() -> void:
	$AnimationPlayer.play("explosion")

func _on_area_entered(area: Area2D) -> void:
	var target_enemy=area.get_parent()
	if target_enemy is Enemy:
		target_enemy.getDamage(1000)
		
func _on_finish_animation():
	queue_free()
