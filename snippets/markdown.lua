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
    pair("$", "$", "$", false),
    pair("$$", "$$", "$$", true)

}
