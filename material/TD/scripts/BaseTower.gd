class_name BaseTower
extends Node2D

var health:float = 100.0
@export var maxHealt:float = 100.0
@export var gridPosition:Vector2
@export var bytesSize:int =16

func initTower():
	health=maxHealt
