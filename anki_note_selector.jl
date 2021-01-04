using JAnki
using REPL.TerminalMenus
using Base: prompt, run

function note_selector(tag, toclip, )

    cards = anki_get_tag("transfer")["result"]

    check_card = anki_get_card(cards[1])["result"][1]
    field_list = check_card["fields"] |> keys |> collect

    println("Select what fields you wish to query from these cards:")
    selections = MultiSelectMenu(field_list, pagesize = 5) |> request
    selections = field_list[selections.dict |> keys |> collect]
    run(`clear`)

    for card in cards
        card = anki_get_card(card)["result"][1]
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

        clipboard(card_info)
        prompt("When ready for the next note, press ENTER")
        run(`clear`)

    end
end

function anki_retag_note(tag, retag)
        println("Would you like to remove $tag and retag it $retag?")
        choice = RadioMenu(["Yes", "No"], pagesize = 2) |> request

        if choice == 1
            anki_add_tag(card_id, "done")
            anki_remove_tag(card_id, "transfer")
        end
end

function main()
main()
