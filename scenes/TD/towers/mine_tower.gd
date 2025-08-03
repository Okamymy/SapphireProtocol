extends BaseTower

@export var explosion_instance: PackedScene


func getDamage(qtyDamage:int):
	var explosion:Explosion = explosion_instance.instantiate()
	get_tree().current_scene.add_child(explosion)
	explosion.global_position=self.global_position
	TdSystemGameManager.puttedTower.erase(gridPosition)
	call_deferred("queue_free")

	
