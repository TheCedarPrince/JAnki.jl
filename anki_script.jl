using JAnki
using HTTP

cards = JAnki.anki_find_notes("transfer")["result"]

for card in cards
           card_info = JAnki.anki_get_card(card)["result"][1]
           println(card_info["noteId"])
           for key in keys(card_info["fields"])
               println("$key:")
               println(card_info["fields"][key]["value"])
               println("\n")
           end
           println("\n\n")
       end

