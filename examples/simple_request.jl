using HTTP

r = HTTP.request("POST", "http://localhost:8765", [], "{\"action\": \"deckNames\", \"version\": 6}")
println(r.status)
println(String(r.body))
