"""
anki_add_tag(card_id::Array{Int})

Adds a tag to cards listed in an array of card IDs.

"""
function anki_add_tag(card_id, tag)
    if length(card_id) == 1
        card_id = "[$card_id]"
    end

    response = HTTP.request(
        :POST,
        "http://localhost:8765",
        [],
        """{
\"action\": \"addTags\",
\"version\": 6,
\"params\": {
	\"notes\": $card_id,
	\"tags\": \"$tag\"
	}
}""",
    )
    String(response.body) |> JSON.parse
end
