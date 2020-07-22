using HTTP
using JSON

function anki_suspend_card(card_id)
	if length(card_id) == 1
		card_id = "[$card_id]"
	end

	response = HTTP.request(:POST, "http://localhost:8765", [], """{
				\"action\": \"suspend\", 
				\"version\": 6, 
				\"params\": {
					\"cards\": $card_id
					}
				}""")
	JSON.parse(String(response.body))
end
