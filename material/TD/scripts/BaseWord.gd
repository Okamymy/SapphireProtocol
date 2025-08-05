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
	
	timerHorde.start()
	
	for enemies in qtyEnemiesPerHorde:
		totalEnemies+=enemies

func hordeInit():
	if(currentHorde >= qtyHorde ):
		return
	
	if(qtyEnemiesPerHorde.size()<currentHorde or timePerHorde.size()<currentHorde):
		return


func enemiesDestroy():
	cuerrentEnemies-=1
	
func formatTime(total_seconds: float) -> String:
	var seconds_int = int(total_seconds)
	
	var hours = seconds_int / 3600
	var minutes = (seconds_int % 3600) / 60
	var seconds = seconds_int % 60
	
	return "%02d:%02d:%02d" % [hours, minutes, seconds]
	
	
func stopTimer():
	if timerHorde != null:
		timerHorde.stop()
