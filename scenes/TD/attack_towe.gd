class_name AttackTower
extends BaseTower

@export var damagePerShot: float = 20
@export var recoil: float = 1
@export var bullet_instance: PackedScene

var isShotDelay:bool = true
var isEnemyNear:bool = true

@onready var timer = $Timer
@onready var marker_2d = $Marker2D

func _ready() -> void:
	initTower()
	timer.wait_time = recoil
	timer.timeout.connect(shot)
	timer.start()


func shot():
	if(isEnemyNear):
		spawner_bullet()
		
func spawner_bullet():
	var bullet:Bullet=bullet_instance.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.global_position=marker_2d.global_position
