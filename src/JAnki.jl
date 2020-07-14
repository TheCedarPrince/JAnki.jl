using HTTP
using JSON

function anki_request_tags()
	response = HTTP.request(:POST, "http://localhost:8765", [], "{\"action\": \"findNotes\", \"version\": 6, \"params\": {\"tag:transfer*\"} }")
	j = JSON.parse(String(response.body))
	return j
end


