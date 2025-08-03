class_name DefemderTower
extends BaseTower

@export var extraHealt: float = 20



func _ready() -> void:
	initTower()
	maxHealt+=extraHealt
	health+=extraHealt
	
