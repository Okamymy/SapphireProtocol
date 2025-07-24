extends Node2D
var current_word:BaseWord
var cursorTower:CursorTower
var isValidCell:bool =false
var showCursorTower:bool=false
var hud:Hud

var puttedTower:Dictionary={}
var currentCard:TowerPanel
var currentPosition:Vector2i
var currentCell: Grid_tower


func _physics_process(delta: float) -> void:
	if cursorTower != null and showCursorTower:
		cursorTower.global_position = get_global_mouse_position()

func selectTower(tower:TowerPanel):
#
	if TdSystemMb.megabytes<tower.priceMB:
		return
	currentCard=tower
	if showCursorTower==false:
		showCursorTower=true
		cursorTower.updateTexture(tower)
		current_word.showCells(true)
		hud.showButtonCancel(true)
		
func updateCurrentCell(pos:Vector2i, cell:Grid_tower ):
	cursorTower.setCellValidate(!puttedTower.has(pos))
	currentPosition=pos
	currentCell=cell

func tryPutTower():
	if currentCard and not puttedTower.has(currentPosition):
		var newTower= currentCard.tower.instantiate()
		current_word.towers.add_child(newTower)
		newTower.global_position= currentCell.global_position
		puttedTower[currentPosition]=newTower
		TdSystemMb.removeByte(currentCard.priceMB)
		currentCard=null
		currentCell=null
		showCursorTower =false
		current_word.showCells(false)
		cursorTower.updateTexture(null)
		hud.showButtonCancel(false)

func cancelTower():
	currentCard=null
	currentCell=null
	showCursorTower =false
	current_word.showCells(false)
	cursorTower.updateTexture(null)
	hud.showButtonCancel(false)
	
