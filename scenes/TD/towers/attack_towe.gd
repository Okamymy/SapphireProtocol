class_name AttackTower
extends BaseTower

@export var damagePerShot: float = 20
@export var recoil: float = 1
@export var bullet_instance: PackedScene

var isShotDelay:bool = true
var isEnemyNear:bool = false


@onready var timer: Timer = $Timer
@onready var marker_2d: Marker2D = $Marker2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
func _process(_delta):
	isEnemyNear = false  # Reiniciamos cada frame
	
	if ray_cast_2d.is_colliding():
		# Problemas al validar si es el enemigo lo dejo directo
		#	var collider = ray_cast_2d.get_collider()
		#	if collider and collider.is_in_group("enemys"):  
		isEnemyNear = true
		

		
func _ready() -> void:
	initTower()
	timer.wait_time = recoil
	timer.timeout.connect(shot)
	timer.start()
	$AnimatedSprite2D.play('default')
	
func shot():
	if(isEnemyNear):
		$AnimationPlayer.play("towershot")
		
		$AnimatedSprite2D.play('shot')
	
	else:
		$AnimatedSprite2D.play('default')
		
func spawner_bullet():
	var bullet:Bullet=bullet_instance.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.global_position=marker_2d.global_position
