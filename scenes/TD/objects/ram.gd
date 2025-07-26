class_name RAM
extends Area2D
@export var qtyram:int=16
@onready var timer: Timer = $Timer

func _ready() -> void:
	$AnimatedSprite2D.play('default')
	$AnimationPlayer.play("start")
	timer.wait_time = 15.0
	timer.one_shot = true
	timer.start()
	timer.timeout.connect(_on_timer_timeout)
	
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_released("click_izquierdo"):
		#sumaRam
		TdSystemMb.addByte(qtyram)
		queue_free()  
		
func _on_timer_timeout():
	queue_free()  
