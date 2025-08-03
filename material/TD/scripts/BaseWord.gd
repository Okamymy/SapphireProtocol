class_name BaseWord
extends Node2D

@export var currentHorde:int=0
@export var qtyHorde:int=5
@export var qtyEnemiesPerHorde:Array[int]=[2]
@export var timePerHorde:Array[float]=[2.7]
@export var levelCode:String
 
var timerHorde:Timer

var totalEnemies:int=0
var totalEnemiesHorde:int=0
var cuerrentEnemies:int=0

@export var lineNode:Node2D

func wordInit():
	timerHorde = Timer.new()
	timerHorde.autostart=false
	timerHorde.one_shot=true
	add_child(timerHorde)
	timerHorde.wait_time=timePerHorde[0]
	
	timerHorde.timeout.connect(hordeInit)
	timerHorde.start()
	
	for enemies in qtyEnemiesPerHorde:
		totalEnemies+=enemies

func hordeInit():
	if(currentHorde >= qtyHorde ):
		return
	
	if(qtyEnemiesPerHorde.size()<currentHorde or timePerHorde.size()<currentHorde):
		return
	#spawn enemies
	enemies_spawner(qtyEnemiesPerHorde[currentHorde]) 
	timerHorde.wait_time=timePerHorde[currentHorde]
	timerHorde.start()
	
func enemies_spawner(total:int):
	pass

func enemiesDestroy():
	cuerrentEnemies-=1
