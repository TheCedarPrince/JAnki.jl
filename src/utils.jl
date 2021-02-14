"""

anki_find_notes(tag::Array)

This 

"""
function anki_find_notes(tag::Array)
    tag_query = ""
    for t in tag 
    	tag_query = tag_query * " tag:$t"
    end
    response = HTTP.request(
        :POST,
        "http://localhost:8765",
        [],
        """{
\"action\": \"findNotes\",
\"version\": 6,
\"params\": {
	\"query\": \"$tag_query\"
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
