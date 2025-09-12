-- @diagnostic disable: undefined-global

local function pair(trig, start, e, auto)
    local typ = "snippet"
    if auto then
        typ = "autosnippet"
    end
    return s(
        {
            trig = trig,
            snippetType = typ
        },
        {
            t(start),
            i(1),
            t(e)
        }
    )
end

return {
    pair("$", "$ ", " $", false),
    s({ trig = "#setup", snippetType = "autosnippet" }, fmt([[
#let important(body) = text(orange, weight: 900)[#body]
#set text(lang: "de", size: 12pt)
#set terms(separator: [: \ ])
#set heading(numbering: "1.1")

#show outline.entry.where(
  level: 1
): set block(above: 1.5em)

#show outline.entry.where(
  level: 2
): set block(above: 1.2em)

#show link: body => text(blue)[#underline(body)]

#outline(title: "{}")
#pagebreak()

= {}
]], {i(1, "title"), i(2, "first heading")})),
}
