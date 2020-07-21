using JAnki
using REPL.TerminalMenus

function main()

card = JAnki.anki_get_tag("transfer")["result"][1]

card_dict = Dict()

card = JAnki.anki_get_card(card)["result"][1]

card_id = card["noteId"]

field_list = collect(keys(card["fields"]))

println("Select what fields you wish to query from these cards:")
selections = request(MultiSelectMenu(field_list, pagesize = 5))
selections = field_list[collect(keys(selections.dict))]

card_info = ""

for selection in selections
	card_info = card_info * " " *  replace(card["fields"][selection]["value"], r"<div>|</div>|\n|\t|<br>|<br/>" => "")
end

card_info
end
