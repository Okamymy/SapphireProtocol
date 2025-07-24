class_name  TowerPanel
extends Panel

@export var textureCard:Texture2D
@export var delay:float = 2.0
@export var priceMB:int = 16
@export var tower: PackedScene

func _ready() -> void:
	#Primeros parametros
	$TextureRect.texture = textureCard
	$Label.text = str(priceMB)
	
	#temporizador
	$Timer.wait_time=delay
	$Timer.one_shot=true

func _on_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("click_izquierdo"):
		TdSystemGameManager.selectTower(self)
