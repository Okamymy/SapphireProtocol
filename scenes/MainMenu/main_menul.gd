extends Control

@onready var panel_settings: Panel = $PanelSettings
@onready var menu_main: VBoxContainer = $MenuMain


var siguiente_escena = preload("res://scenes/TD/levels/word01.tscn")

# Main menu
func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(siguiente_escena)


func _on_settings_pressed() -> void:
	menu_main.visible=false
	panel_settings.visible=true
	

# Settings
func _on_back_settings_button_up() -> void:
	menu_main.visible=true
	panel_settings.visible=false
