extends Control

@onready var panel_settings: Panel = $PanelSettings
@onready var menu_main: VBoxContainer = $MenuMain


const siguiente_escena = preload("res://scenes/TD/levels/level0/level00.tscn")
@onready var option_button: OptionButton = $EnterUser/HBoxContainer/MarginContainer2/VBoxContainer2/OptionButton

func _ready() -> void:
	var consulta_sql = "SELECT nombre FROM jugador"
	var queryUser =await ConctorDB.set_query(consulta_sql)
	var usersname=[]
	for data in queryUser:
		usersname.append(data.nombre)
	for item in usersname:
		option_button.add_item(item)




# Main menu
func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(siguiente_escena)


func _on_settings_pressed() -> void:
	menu_main.visible=false
	panel_settings.visible=true

func _on_achievements_pressed() -> void:
	var consulta_sql = "SELECT * FROM jugador"
	var ola =await ConctorDB.enviar_consulta(consulta_sql)
	print(ola)

# Settings
func _on_back_settings_button_up() -> void:
	menu_main.visible=true
	panel_settings.visible=false

var master_bus_index: int
func _on_h_scroll_bar_value_changed(value: float) -> void:

	master_bus_index = AudioServer.get_bus_index("Master")
	var current_volume_db = AudioServer.get_bus_volume_db(master_bus_index)
	var volume_db: float
	if value == 0:
		volume_db = -80.0
	else:
		volume_db = linear_to_db(value)
	AudioServer.set_bus_volume_db(master_bus_index, volume_db)


# EnterUser
