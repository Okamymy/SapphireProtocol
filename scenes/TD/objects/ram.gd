class_name RAM
extends Area2D
@export var qtyram:int=16

func _ready() -> void:
	$AnimatedSprite2D.play('default')
	$AnimationPlayer.play("start")

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_released("click_izquierdo"):
		
		#sumaRam
		TdSystemMb.addByte(qtyram)
		call_deferred("queue_free")  
