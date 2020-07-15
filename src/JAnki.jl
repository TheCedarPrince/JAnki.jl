using HTTP
using JSON

function anki_get_tag(tag)
	response = HTTP.request(:POST, "http://localhost:8765", [], """{
				\"action\": \"findNotes\", 
				\"version\": 6, 
				\"params\": {
					\"query\": \"tag:$tag*\"
					}
				}""")
	JSON.parse(String(response.body))
end


function anki_get_card(card_id)
	if length(card_id) == 1
		card_id = "[$card_id]"
	end

	response = HTTP.request(:POST, "http://localhost:8765", [], """{
				\"action\": \"notesInfo\", 
				\"version\": 6, 
				\"params\": {
					\"notes\": $card_id
					}
				}""")
	JSON.parse(String(response.body))
end

