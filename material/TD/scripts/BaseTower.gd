class_name BaseTower
extends Node2D

var health:int
@export var maxHealt:int = 100.0
@export var gridPosition:Vector2
@export var megabytesSize:int =16

func initTower():
	health=maxHealt
	

func getDamage(qtyDamage:int):
	health-=qtyDamage
	if (health<=0):
		queue_free()
