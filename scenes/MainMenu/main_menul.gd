extends Control

@onready var panel_settings: Panel = $PanelSettings
@onready var menu_main: VBoxContainer = $MenuMain
@onready var option_button_user: OptionButton = $EnterUser/RegistrerUser/VBoxContainer2/OptionButtonUser

var queryUser=[]

func _ready() -> void:
	if DataUserSystem.username:
		$EnterUser.visible=false
		$UserNameLabel.text=DataUserSystem.username
	else:
		var query_sql = "SELECT nombre FROM jugador"
		queryUser =await ConctorDB.set_query(query_sql)
		for data in queryUser:
			option_button_user.add_item(data.nombre)


# Main menu
func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_play_pressed() -> void:
	TdSystemGameManager.change_scene("res://scenes/TD/levels/level0/level00.tscn")


func _on_settings_pressed() -> void:
	menu_main.visible=false
	panel_settings.visible=true



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
@onready var user_name_label: Label = $UserNameLabel
@onready var enter_user: Panel = $EnterUser
func _on_button_select_user_pressed() -> void:
	var user = option_button_user.get_item_text(option_button_user.get_selected_id())
	if user:
		DataUserSystem.getUserName(user)
		enter_user.visible=false
		user_name_label.text=user
		var query = "update Jugador set ultimaConexion=CURDATE() WHERE nombre='%s' "% [user]
		var queryUser =await ConctorDB.set_query(query)

@onready var register_user_text: LineEdit = $EnterUser/LoginUser/VBoxContainer/registerUserText

func _on_button_register_user_pressed() -> void:
	if(register_user_text.text):
		for data in queryUser:
			if (data.nombre==register_user_text.text):
				return
		var query = "INSERT INTO Jugador (nombre, fechaCreacion, ultimaConexion, eMail) VALUES ('%s', CURDATE(), CURDATE(), '%s@sapphire.gov')" % [register_user_text.text,register_user_text.text]
		var queryUser =await ConctorDB.set_query(query)
		DataUserSystem.getUserName(register_user_text.text)
		enter_user.visible=false
		user_name_label.text=register_user_text.text


@onready var registrer_user: MarginContainer = $EnterUser/RegistrerUser
@onready var login_user: MarginContainer = $EnterUser/LoginUser

func _on_go_to_register_pressed() -> void:
	registrer_user.visible = true
	login_user.visible = false


func _on_go_to_login_pressed() -> void:
	login_user.visible = true
	
	registrer_user.visible =false

#userData

@onready var panel_user_data: Panel = $PanelUserData
@onready var data_panel_user_data: RichTextLabel = $PanelUserData/DataPanelUserData

func _on_user_data_pressed() -> void:
	var query = "SELECT 
					j.noJugador,
					j.nombre AS nombreJugador,
					j.eMail,
					j.fechaCreacion,
					j.ultimaConexion,
					COUNT(DISTINCT p.noPartida) AS totalPartidas,
					SEC_TO_TIME(SUM(TIME_TO_SEC(p.tiempoTotalJugado))) AS tiempoTotalJugado,
					(
						SELECT COUNT(*) 
						FROM LogrosObtenidos lo 
						WHERE lo.jugador = j.noJugador
					) AS logrosObtenidos,
					(
						SELECT c1.cantidadActual
						FROM Cartera c1
						WHERE c1.partida = (
							SELECT MAX(p2.noPartida) 
							FROM Partida p2 
							WHERE p2.jugador = j.noJugador
						)
						AND c1.divisaCodigo = 'CRAM'
					) AS RAMMaximaActual,
					(
						SELECT c2.cantidadActual
						FROM Cartera c2
						WHERE c2.partida = (
							SELECT MAX(p3.noPartida) 
							FROM Partida p3 
							WHERE p3.jugador = j.noJugador
						)
						AND c2.divisaCodigo = 'CCRE'
					) AS creditosActuales
				FROM Jugador j
				LEFT JOIN Partida p ON p.jugador = j.noJugador
				WHERE j.nombre = '%s' 
				GROUP BY j.noJugador;" % [DataUserSystem.username]
	var queryUser =await ConctorDB.set_query(query)
	var player=queryUser[0]
	var textFormat = "Player #" + player["noJugador"] + " - " + player["nombreJugador"] + "\n" \
	+ "Email: " + player["eMail"] + "\n" \
	+ "date create: " + player["fechaCreacion"] + "\n" \
	+ "last conection: " + player["ultimaConexion"] + "\n" \
	+ "Total de partidas: " + player["totalPartidas"] + "\n" \
	+ "Tiempo total jugado: " + player["tiempoTotalJugado"] + "\n" \
	+ "Logros obtenidos: " + player["logrosObtenidos"] + "\n" \
	+ "RAM máxima actual: " + player["RAMMaximaActual"] + " MB\n" \
	+ "Créditos actuales: " + player["creditosActuales"]
	data_panel_user_data.text=textFormat
	panel_user_data.visible=true


func _on_back_panel_user_data_pressed() -> void:
	panel_user_data.visible=false


#Scrollboard
@onready var panel_score_board: Panel = $PanelScoreBoard

@onready var scoreboard_text_names: RichTextLabel = $PanelScoreBoard/HBoxContainer/VBoxContainer2/ScoreboardTextNames
@onready var scoreboard_text_scores: RichTextLabel = $PanelScoreBoard/HBoxContainer/VBoxContainer/ScoreboardTextScores


func _on_score_board_pressed() -> void:
	scoreboard_text_names.text=''
	scoreboard_text_scores.text=''
	var query = "SELECT 
					j.nombre AS nombreJugador,
					SUM(rn.puntajeMayor) AS puntajeTotal
				FROM Jugador j
				JOIN Partida p ON p.jugador = j.noJugador
				JOIN ResultadosNivel rn ON rn.noPartida = p.noPartida
				GROUP BY j.noJugador, j.nombre
				ORDER BY puntajeTotal DESC
				LIMIT 10; 
	"
	var queryUser =await ConctorDB.set_query(query)
	for data in queryUser:
		scoreboard_text_names.text+=data.nombreJugador + "\n"
		scoreboard_text_scores.text+=data.puntajeTotal + "\n"
	panel_score_board.visible= true
	

func _on_back_score_board_pressed() -> void:
	panel_score_board.visible = false
