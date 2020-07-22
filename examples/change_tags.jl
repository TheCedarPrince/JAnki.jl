using HTTP
using JSON

function anki_add_tag(card_id, tag)
	if length(card_id) == 1
		card_id = "[$card_id]"
	end

	response = HTTP.request(:POST, "http://localhost:8765", [], """{
				\"action\": \"addTags\", 
				\"version\": 6, 
				\"params\": {
					\"notes\": $card_id,
					\"tags\": \"$tag\"
					}
				}""")
	JSON.parse(String(response.body))
end

function anki_remove_tag(card_id, tag)
	if length(card_id) == 1
		card_id = "[$card_id]"
	end

	response = HTTP.request(:POST, "http://localhost:8765", [], """{
				\"action\": \"removeTags\", 
				\"version\": 6, 
				\"params\": {
					\"notes\": $card_id,
					\"tags\": \"$tag\"
					}
				}""")
	JSON.parse(String(response.body))
end
