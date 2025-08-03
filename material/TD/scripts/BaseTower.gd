class_name BaseTower
extends Node2D

var health:int
@export var maxHealt:int = 100.0
@export var gridPosition:Vector2i
@export var megabytesSize:int =16
@export var codeTower=''



func initTower():
	health=maxHealt
	

func getDamage(qtyDamage:int):
	health-=qtyDamage
	if (health<=0):
		TdSystemGameManager.puttedTower.erase(gridPosition)
		queue_free()
