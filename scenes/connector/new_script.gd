extends Control

@onready var http_request = $HTTPRequest

func _ready():
	http_request.request_completed.connect(_on_request_completed)
	
	var consulta_sql = "SELECT * FROM jugador "
	
	enviar_consulta(consulta_sql)

func enviar_consulta(query_string: String):
	var url = "http://localhost/sapphire.php"
	
	var cuerpo = "query=" + query_string.uri_encode()
	
	var headers = ["Content-Type: application/x-www-form-urlencoded"]
	
	print("Enviando consulta: ", query_string)
	var error = http_request.request(url, headers, HTTPClient.METHOD_POST, cuerpo)
	if error != OK:
		print("Error al iniciar la petición.")

func _on_request_completed(result, response_code, headers, body):
	var texto_respuesta = body.get_string_from_utf8()
	var json = JSON.parse_string(texto_respuesta)

	if not json:
		print("Error al parsear el JSON: ", texto_respuesta)
		return

	if json.get("success"):
		var datos = json.get("data", [])
		print("Resultados de la consulta: ", datos)
	else:
		var mensaje = json.get("message", "Error desconocido.")
		print("El servidor PHP devolvió un error: ", mensaje)
