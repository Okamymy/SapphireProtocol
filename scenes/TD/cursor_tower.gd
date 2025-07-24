class_name CursorTower
extends Node2D
@onready var sprite_2d: Sprite2D = $Sprite2D
func _ready() -> void:
	sprite_2d.scale=Vector2(.5,.5)
	
func updateTexture(tower:TowerPanel):
	if (tower==null):
		sprite_2d.texture=null
		return
	sprite_2d.texture = tower.textureCard
	

func  setCellValidate(value:bool):
	if value:
		sprite_2d.self_modulate = Color(1.0, 1.0, 1.0, 0.4)
	else:
		sprite_2d.self_modulate = Color(1.0, 0.0, 0.0, 0.435)
		
