class_name BaseTower
extends Node2D

var health:int
@export var maxHealt:int = 100.0
@export var gridPosition:Vector2i
@export var megabytesSize:int =16
@export var codeTower=''


func initTower():
	health=maxHealt
	
	var tower_found = false
	for dict_tower in DataUserSystem.currentTowersCodes:
		if dict_tower["code"] == codeTower:
			dict_tower["qty"] += 1
			dict_tower["damage"] += 16
			tower_found = true
			break
			
	if not tower_found:
		DataUserSystem.currentTowersCodes.append({"code": codeTower, "qty": 1, "damage":16 })


func getDamage(qtyDamage:int):
	health-=qtyDamage
	if (health<=0):
		TdSystemGameManager.puttedTower.erase(gridPosition)
		queue_free()
