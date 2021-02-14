module JAnki

using HTTP
using JSON

include("adders.jl")
include("getters.jl")
include("utils.jl")

export anki_get_card, anki_get_tags
export anki_find_notes, anki_find_notess
export anki_add_tag, anki_remove_tag
export anki_suspend_card

end
