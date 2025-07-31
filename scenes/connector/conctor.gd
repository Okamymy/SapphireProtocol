extends Control
@onready var http_request: HTTPRequest = $HTTPRequest


func set_query(query_string: String) -> Variant:
	var url = "http://localhost/sapphire.php"
	var bodyhttp = "query=" + query_string.uri_encode()
	var headers = ["Content-Type: application/x-www-form-urlencoded"]

	var error = http_request.request(url, headers, HTTPClient.METHOD_POST, bodyhttp)
	if error != OK:
		return null

	var result: Array = await http_request.request_completed
	var response_code = result[1]
	var body = result[3]
	
	if response_code != 200:
		print("ERROR: El servidor devolvió el código: ", response_code)
		return null
	var text_result = body.get_string_from_utf8()
	var json = JSON.parse_string(text_result)

	if not json:
		print("ERROR: No se pudo parsear el JSON. La respuesta fue:")
		print(text_result)
		return null

	if json.get("success"):
		var datos = json.get("data", [])
		return datos
	else:
		var message = json.get("message", "Error desconocido.")
		print("ERROR del PHP: ", message)
		return null
