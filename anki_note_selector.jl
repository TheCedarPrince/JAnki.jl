using JAnki
using REPL.TerminalMenus
using Base

function main()

cards = JAnki.anki_get_tag("transfer")["result"]

check_card = JAnki.anki_get_card(cards[1])["result"][1]	
field_list = collect(keys(check_card["fields"]))

println("Select what fields you wish to query from these cards:")	
selections = request(MultiSelectMenu(field_list, pagesize = 5))	
selections = field_list[collect(keys(selections.dict))]

for card in cards
	card = JAnki.anki_get_card(card)["result"][1]
	card_id = card["noteId"]
	field_list = collect(keys(card["fields"]))

	card_info = ""

	for selection in selections
		card_info = card_info * " " *  replace(card["fields"][selection]["value"], r"<div>|</div>|\n|\t|<br>|<br/>" => "")
	end

	clipboard(card_info)
	println("\n" * card_info * "\n")
	
	println("Would you like to finish the card?")	
	choice = request(RadioMenu(["Yes", "No"], pagesize = 2))

	if choice == 1
		JAnki.anki_add_tag(card_id, "done")
		JAnki.anki_remove_tag(card_id, "transfer")
	end

	Base.prompt("When ready for the next note, press ENTER")
end
end
