class_name Hud
extends Control
@onready var bytes_qty: Label = $MBPanel/MBgrit/bytes_qty

func _ready() -> void:
	TdSystemMb.UpdateBytes.connect(updateMB)
	TdSystemGameManager.hud=self
	$Button.visible=false

	
func updateMB(byte:int):
	bytes_qty.text = str(byte)


func _on_button_button_down() -> void:
	TdSystemGameManager.cancelTower()


func showButtonCancel(value:bool):
	$Button.visible=value
