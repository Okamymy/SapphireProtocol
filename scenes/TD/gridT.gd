class_name Grid_tower
extends Area2D

var cellPosition:Vector2i

func _on_mouse_entered():
	TdSystemGameManager.updateCurrentCell(cellPosition, self)


func _on_mouse_exited() -> void:
	pass # Replace with function body.


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("click_izquierdo"):
		TdSystemGameManager.tryPutTower()
