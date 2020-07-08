using HTTP

r = HTTP.request("POST", "http://localhost:8765", verbose = 3)
println(r.status)
println(String(r.body))
