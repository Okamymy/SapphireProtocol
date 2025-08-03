extends Node

@export var username:String
@export var tempPoints:int
var tempPointsEnemies:int
var tempPointsTowers:int

@export var currentEnemiesCodes=[]
@export var currentTowersCodes=[]



func getUserName(name):
	username=name
	
func clearCodesUsed():
	currentEnemiesCodes=[]
	currentTowersCodes=[]
	
