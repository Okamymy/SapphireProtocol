extends Control

@onready var start: Button = $start
@onready var exit: Button = $exit
@onready var options: Button = $options
@onready var achievements: Button = $achievements

var siguiente_escena = preload("res://scenes/TD/word01.tscn")

func _on_start_pressed() -> void:
	get_tree().change_scene_to_packed(siguiente_escena)


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_options_pressed() -> void:
	print('ola')
 # Replace with function body.


func _on_achievements_pressed() -> void:
	print('ola')
 # Replace with function body.
