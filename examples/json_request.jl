using HTTP
using JSON


function anki_request()
	response = HTTP.request("POST", "http://localhost:8765", [], "{\"action\": \"deckNames\", \"version\": 6}")
	j = JSON.parse(String(response.body))
	return j
end
