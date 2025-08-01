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

# --- Variables para controlar la oleada ---
var beat_times: Array = []
var current_beat_index: int = 0
var wave_is_active: bool = false

func _ready():
	bg_animation.play("new_animation")
	
	TdSystemGameManager.current_word = self
	TdSystemGameManager.cursorTower = $cursor
	makeGrid()
	cells.visible = false
	
	wordInit()
	
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
