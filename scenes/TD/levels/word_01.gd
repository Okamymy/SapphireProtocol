extends BaseWord

@onready var cells = $cells
@onready var cursor = $cursor
@onready var towers: Node2D = $towers
@onready var bg_animation: AnimationPlayer = $bgAnimation

# Obtenemos una referencia al reproductor de audio
@onready var music_player = $AudioStreamPlayer2D

# Archivo JSON con los tiempos
const BEATS_DATA = preload("res://scenes/TD/levels/level0/beats.json")

# Lista de escenas de enemigos para elegir al azar
const ENEMY_TYPES = [
	preload("res://scenes/TD/enemies/ene_fast.tscn"),
	preload("res://scenes/TD/enemies/ene_heavy.tscn"),
	preload("res://scenes/TD/enemies/ene_light.tscn"),
	preload("res://scenes/TD/enemies/ene_medium.tscn")
]

# Puntos de spawn
@onready var MARKERS = [$lines/Marker2D, $lines/Marker2D5, $lines/Marker2D6, $lines/Marker2D2, $lines/Marker2D3, $lines/Marker2D4]
const MAIN_MENUL = preload("res://scenes/MainMenu/MainMenul.tscn")

# --- Variables para controlar la oleada ---
var beat_times: Array = []
var current_beat_index: int = 0
var wave_is_active: bool = false

func _ready():
	wordInit()
	bg_animation.play("new_animation")
	TdSystemGameManager.current_word = self
	TdSystemGameManager.cursorTower = $cursor
	makeGrid()
	cells.visible = false
	
	# Inicia la oleada de enemigos y la música
	start_wave()
	music_player.play()
	

func _process(delta: float):
	if not wave_is_active or current_beat_index >= beat_times.size():
		return
	var current_music_time = music_player.get_playback_position()
	
	if current_music_time >= beat_times[current_beat_index]:
		spawn_random_enemy()
		current_beat_index += 1
		if current_beat_index >= beat_times.size():
			wave_is_active = false 
			EndLevel()
			
const CHARSET = "abcdefghijklmnopqrstuvwxyz0123456789"
func generate_random_string(length: int) -> String:
	var result = ""
	for i in range(length):
		# Pick a random character from the charset string
		var random_char = CHARSET[randi_range(0, CHARSET.length() - 1)]
		# Append it to our result
		result += random_char
	return result
func start_wave():
	if BEATS_DATA and BEATS_DATA.data is Array:
		beat_times = BEATS_DATA.data
		wave_is_active = true
	else:
		print("Error: No se pudieron cargar los datos de beats.json")

func spawn_random_enemy():
	if MARKERS.is_empty() or ENEMY_TYPES.is_empty():
		print("Error: No hay marcadores o tipos de enemigos definidos.")
		return
	
	var random_enemy_scene = ENEMY_TYPES.pick_random()
	var random_marker = MARKERS.pick_random()
	
	var new_enemy = random_enemy_scene.instantiate()
	add_child(new_enemy)
	new_enemy.global_position = random_marker.global_position

func showCells(value:bool):
	cells.visible = value

func makeGrid():
	var cellPackage:= load("res://scenes/TD/grid.tscn")
	for x in range(0,10):
		for y in range(0,6):
			var newCell = cellPackage.instantiate()
			newCell.cellPosition = Vector2i(x, y)
			cells.add_child(newCell)
			newCell.position = Vector2(150,170) + (Vector2(x,y) * Vector2(87,86))
			
			
func EndLevel():
	stopTimer()
	var timeLeftPlayed= formatTime(timerHorde.time_left)
	var numberLevelQuery="
			SELECT  p.noPartida
			FROM Jugador as j
			inner join partida as p on p.jugador = j.noJugador
			WHERE j.nombre = '%s' "%[DataUserSystem.username]
	var numberLevel = await ConctorDB.set_query(numberLevelQuery)
	var resultLevelQuery="
		select codigo
		from `resultadosnivel` 
		WHERE nivel='%s' and noPartida = %s
	"%[levelCode,numberLevel[0].noPartida]
	var resultLevel =await ConctorDB.set_query(numberLevelQuery)
	
	if resultLevel:
		pass
	else:
		var codeResultLevel=generate_random_string(5)
		var query = "
					INSERT INTO ResultadosNivel (codigo, noPartida, nivel, puntajeMayor, intentos, mejorTiempo) VALUES ('%s', %s, '%s',  '%s', 1, '%s')" % [codeResultLevel,numberLevel[0].noPartida, levelCode, DataUserSystem.tempPoints,timeLeftPlayed] 
		var queryUser = await ConctorDB.set_query(query)
		
		for data in DataUserSystem.currentEnemiesCodes:
			query = "
					INSERT INTO Niv_Ene (nivel, enemigo, cantidad) VALUES ('%s', '%s', %s)"%[levelCode, data.code, data.qty]
			var queryTower = await ConctorDB.set_query(query)
		for data in DataUserSystem.currentEnemiesCodes:
			query = "
					INSERT INTO Niv_Tor (resultadoNivel, torreta, cantidadUsada, danoTotal) VALUES ('%s', '%s', %s, %s)" % [codeResultLevel, data.code, data.qty, data.damage]
			var queryEnemies = await ConctorDB.set_query(query)
	$CanvasLayer2/GameOver.visible=true

func _on_game_over_area_area_entered(area: Area2D):
	$CanvasLayer2/GameOver.visible=true
