extends Control
@onready var bytes_qty: Label = $HBoxContainer/bytes_qty

func _ready() -> void:
	TdSystemBytes.UpdateBytes.connect(updateBytes)

func updateBytes(byte:int):
	bytes_qty.text = str(byte)
