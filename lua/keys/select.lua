local keys = require("keys.util")

keys.smap("<Tab>", function () keys.snippet_move(1, "<Tab>") end)
keys.smap("<S-Tab>", function () keys.snippet_move(-1, "<S-Tab>") end)
