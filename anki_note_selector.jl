using JAnki
using REPL.TerminalMenus
using Base: prompt, run

"""

note_selector(tag::String, retag::String, toclip::Bool)

"""
function note_selector(tags::Array, retag::String, toclip::Bool)

    cards = anki_find_notes(tags)["result"]

    if length(cards) == 0
        println("No cards found that match \"$(tags)\". Exiting program")
	return 0
    end

    check_card = anki_get_card([cards[1]])[1]
    field_list = check_card["fields"] |> keys |> collect

    println("Select what fields you wish to query from these cards:")
    selections = MultiSelectMenu(field_list, pagesize = 5) |> request
    selections = field_list[selections.dict |> keys |> collect]
    run(`clear`)

    for (num, card) in enumerate(cards)
        card = anki_get_card([card])[1]
        card_id = card["noteId"]
        field_list = card["fields"] |> keys |> collect

        card_info = ""

        for selection in selections
            if card["fields"][selection]["value"] |> !isempty
                content =
                    "$selection: " * card["fields"][selection]["value"] |>
                    x ->
                        replace(x, r"<div>|</div>|<i>|</i>|\t|<br>|<br/>|\n" => "") |>
                        x ->
                            replace(x, r"&nbsp;" => " ") |>
                            x ->
                                replace(x, r"“|”" => "\"") |>
                                x -> replace(x, r"’" => "\'") * "\n"
                println(content)
                card_info = card_info * content
            end
        end
        println("Card $num of $(length(cards))")

        if toclip
            clipboard(card_info)
            anki_retag_note(tags, retag, card_id)
            prompt("When ready for the next note, press ENTER")
            run(`clear`)
        end
    end
end

"""

anki_retag_note(tag::String, retag::String, card_id::String)

"""
function anki_retag_note(tag, retag, card_id)
    println("Would you like to remove $tag and from this card and retag it \"$retag\"?")
    choice = RadioMenu(["Yes", "No"], pagesize = 2) |> request

    if choice == 1
        anki_add_tag(card_id, "$retag")
        anki_remove_tag(card_id, "$tag")
    end
end

note_selector(["transfer"], "done", true)
println("No more cards to review! Hooray!!! 🎉 🎉 🎉")
