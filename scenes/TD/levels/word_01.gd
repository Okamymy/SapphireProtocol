extends BaseWord


@onready var cells = $cells
@onready var cursor = $cursor
@onready var towers: Node2D = $towers


func _ready():
	TdSystemGameManager.current_word = self
	TdSystemGameManager.cursorTower = $cursor
	makeGrid()
	cells.visible=false
	
	wordInit()

func showCells(value:bool):
	cells.visible=value

func makeGrid():
	var cellPackage:= load("res://scenes/TD/grid.tscn")
	for x in range(0,9):
		for y in range(0,4):
			var newCell =cellPackage.instantiate()
			newCell.cellPosition = Vector2i(x, y)
			cells.add_child(newCell)
			newCell.position =Vector2(150,200)+(Vector2(x,y)* Vector2(108,117))
			
