module JAnki

using HTTP
using JSON

"""

anki_get_tags()

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

anki_find_notes(tag::String)

This 

"""
function anki_find_notes(tag::String)
    response = HTTP.request(
        :POST,
        "http://localhost:8765",
        [],
        """{
\"action\": \"findNotes\",
\"version\": 6,
\"params\": {
	\"query\": \"tag:$tag*\"
	}
}""",
    )
    String(response.body) |> JSON.parse
end

"""

anki_get_card(card_id::Array{Int64})

Returns a list of cards 

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
    String(response.body) |> JSON.parse
end

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

"""

anki_remove_tag(card_id::Int, tag::String)

"""
function anki_remove_tag(card_id, tag)
    if length(card_id) == 1
        card_id = "[$card_id]"
    end

    response = HTTP.request(
        :POST,
        "http://localhost:8765",
        [],
        """{
\"action\": \"removeTags\",
\"version\": 6,
\"params\": {
	\"notes\": $card_id,
	\"tags\": \"$tag\"
	}
}""",
    )
    String(response.body) |> JSON.parse
end

"""

anki_suspend_card(card_id::Array{Int64})

Suspends an array of given card IDs within Anki.

"""
function anki_suspend_card(card_id::Array{Int64})
    response = HTTP.request(
        :POST,
        "http://localhost:8765",
        [],
        """{
\"action\": \"suspend\",
\"version\": 6,
\"params\": {
	\"cards\": $card_id
	}
}""",
    )
end

export anki_get_card, anki_find_notes, anki_find_notess
export anki_add_tag, anki_remove_tag
export anki_suspend_card

end
