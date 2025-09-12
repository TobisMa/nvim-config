--- @diagnostic disable: undefined-global

local function pair(trig, start, e)
    return s({trig=trig, snippetType="autosnippet"}, {t(start), i(1), t(e)})
end


return {
    pair("(", "(", ")"),
    pair("[", "[", "]"),
    pair("{", "{", "}"),
    pair("<", "<", ">"),
    pair("\"", "\"", "\""),
    s("date", t(os.date("%d.%m.%Y")))
}

