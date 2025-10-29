local function pair(trig, start, e)
    return s({trig=trig, wordTrig=false, snippetType="autosnippet"}, {t(start), i(1), t(e)})
end


return {
    pair("{%", "{%", "%}"),
}
