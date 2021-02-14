"""

	`anki_get_tags()`

This function gets all the tags found in a user's Anki profile.

# Returns:

- `Array{Any, 1}` - a list of strings representing the tags found in a user's profile.

"""
function anki_get_tags()
    response = HTTP.request(
        :POST,
        "http://localhost:8765",
        [],
        """{
\"action\": \"getTags\",
\"version\": 6
}""",
    )
    tags = String(response.body) |> JSON.parse
    return tags["result"]
end

"""

anki_get_card(card_id::Array{Int64})

Returns the contents of cards given an array of card IDs.

# Arguments:

- `card_id::Array{Int64}` - an array of card IDs.

# Returns:

- `Array{Any, 1}` - an array where each object contains card information on a different card.

"""
function anki_get_card(card_id::Array{Int64})
    response = HTTP.request(
        :POST,
        "http://localhost:8765",
        [],
        """{
\"action\": \"notesInfo\",
\"version\": 6,
\"params\": {
	\"notes\": $card_id
	}
}""",
    )
    String(response.body) |> JSON.parse |> x -> x["result"]
end
