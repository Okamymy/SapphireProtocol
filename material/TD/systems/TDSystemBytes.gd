extends Node
signal UpdateBytes(qty)
var bytes:int=16
# son mb
func addByte(qty):
	bytes=+qty
	UpdateBytes.emit(bytes)
	
func removeByte(qty):
	bytes=-qty
	UpdateBytes.emit(bytes)
	
