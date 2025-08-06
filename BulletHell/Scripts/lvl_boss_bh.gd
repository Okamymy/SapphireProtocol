extends Node2D

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func score_update_boss(points):
	score = score + points
	$HUD.update_score(score)

func _on_player_player_hit(actualife):
	$HUD.update_life(actualife)


func _on_player_player_death():
	pass # Codigo para despues de la muerte jugador


func _on_boss_01_boss_death():
	pass # Codigo al derrotar al jefe
