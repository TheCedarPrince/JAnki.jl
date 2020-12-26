module JAnki

using HTTP
using JSON

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

function anki_get_tag(tag)
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
    JSON.parse(String(response.body))
end

function anki_get_card(card_id)
    if length(card_id) == 1
        card_id = "[$card_id]"
    end

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
    JSON.parse(String(response.body))
end

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
    JSON.parse(String(response.body))
end

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
    JSON.parse(String(response.body))
end

function anki_suspend_card(card_id)
    if length(card_id) == 1
        card_id = "[$card_id]"
    end

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
    JSON.parse(String(response.body))
end

export anki_get_card, anki_get_tag, anki_get_tags
export anki_add_tag, anki_remove_tag
export anki_suspend_card

end
