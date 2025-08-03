class_name Enemy
extends CharacterBody2D
#estados
enum{
	MOVE,
	EAT,
	DESTROY
}
var currentState = MOVE
var previusState 

#salud
@export var maxHealth:int =64
var currentHealth:int =20

#movimiento
@export var speed:float = 25
var direction :=-1
#putuacion que suelta
@export var pointsToDei:int=0
#Ataque
@export var damage:int = 16
@export var dalay:float=1.5
var currentAttackTower:BaseTower

@export var qtr_free:int=16

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var delayPerDamge: Timer = $Timer
@export var RAM_Scene:PackedScene
func _ready() :
	delayPerDamge.wait_time=dalay
	delayPerDamge.connect("timeout",attackTower)
	currentHealth=maxHealth


@warning_ignore("unused_parameter")
func _physics_process(delta: float):
	if currentState!= previusState:
		match currentState:
			MOVE:
				pass
			EAT:
				pass
			DESTROY:
				pass
		previusState=currentState
	if currentState==MOVE:
		velocity.x=speed*direction
	else:
		velocity.x=0
	move_and_slide()



func _on_area_2d_area_entered(area: Area2D) -> void:
	currentState=EAT
	currentAttackTower=area.get_parent()
	attackTower()


@warning_ignore("unused_parameter")
func _on_area_2d_area_exited(area: Area2D) -> void:
	currentState=MOVE
	currentAttackTower=null
	delayPerDamge.stop()

func attackTower():
	if (currentAttackTower != null):
		currentAttackTower.getDamage(damage)
		delayPerDamge.start()

func getDamage(qtyDamage:int, effect:String=''):
	match effect:
		'slowing':
			speed=20
	currentHealth-= qtyDamage
	if (currentHealth <= 0):
		#instancia una ram
		call_deferred("_on_death")
		
func _on_death():
	var newRAM: RAM = RAM_Scene.instantiate()
	DataUserSystem.tempPoints+=pointsToDei
	get_tree().current_scene.add_child(newRAM)
	newRAM.global_position = self.global_position
	newRAM.qtyram=qtr_free
	queue_free()
