extends Node
signal UpdateBytes(qty)
var megabytes:int=80
# son mb
func _ready() -> void:
	await get_tree().create_timer(0.01).timeout
	UpdateBytes.emit(megabytes)
	
	
func addByte(qty):
	megabytes+=qty
	UpdateBytes.emit(megabytes)
	
func removeByte(qty):
	megabytes-=qty
	UpdateBytes.emit(megabytes)
	
